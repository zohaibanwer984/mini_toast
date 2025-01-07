import 'package:flutter/material.dart';
import 'configs/quick_toast_config.dart';
import 'models/toast_data.dart';
import 'models/toast_variant.dart';
import 'widgets/toast_view.dart';
import 'toast_overlay.dart';

class _ActiveToast {
  final ToastData data;
  final OverlayEntry entry;

  _ActiveToast({
    required this.data,
    required this.entry,
  });
}

class QuickToast {
  static final QuickToast instance = QuickToast._();
  QuickToast._();

  final List<_ActiveToast> _activeToasts = [];
  QuickToastConfig _config = const QuickToastConfig();

  /// Set global configuration for all toasts
  void setConfig(QuickToastConfig config) {
    _config = config;
  }

  void show({
    required String message,
    ToastVariant variant = ToastVariant.info,
    Duration? duration,
    TextStyle? textStyle,
    Alignment? alignment,
    ToastSlideDirection? slideDirection,
  }) {
    final overlayState = _getOverlayState();
    if (overlayState == null) return;

    // Create toast data with proper alignment
    final toastData = ToastData(
      message: message,
      variant: variant,
      duration: duration ?? _config.displayDuration,
      textStyle: textStyle,
      alignment: alignment ?? _config.alignment,
      slideDirection: slideDirection ?? _config.slideDirection,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) {
        final index = _activeToasts.indexWhere((t) => t.entry == entry);
        return Material(
          type: MaterialType.transparency,
          child: _ToastPosition(
            position: index,
            alignment: _config.alignment,
            config: _config,
            child: ToastView(
              data: toastData,
              config: _config,
              onDismiss: () => _removeToast(entry),
            ),
          ),
        );
      },
    );

    final activeToast = _ActiveToast(
      data: toastData,
      entry: entry,
    );

    _activeToasts.add(activeToast);
    overlayState.insert(entry);

    Future.delayed(toastData.duration, () {
      _removeToast(entry);
    });
  }

  void _removeToast(OverlayEntry entry) {
    final index = _activeToasts.indexWhere((toast) => toast.entry == entry);
    if (index != -1) {
      entry.remove();
      _activeToasts.removeAt(index);
      // Update positions of remaining toasts
      for (var toast in _activeToasts) {
        toast.entry.markNeedsBuild();
      }
    }
  }

  OverlayState? _getOverlayState() {
    final state = overlayKey.currentState;
    assert(() {
      if (state == null) {
        throw FlutterError('''
ToastOverlayState not found. Ensure ToastOverlayWrapper is in your widget tree:
  ToastOverlayWrapper(
    child: MaterialApp(
      home: YourHomePage(),
    ),
  );
''');
      }
      return true;
    }());
    return state?.overlayState;
  }
}

class _ToastPosition extends StatelessWidget {
  final int position;
  final Widget child;
  final Alignment alignment;
  final QuickToastConfig config;

  const _ToastPosition({
    required this.position,
    required this.child,
    required this.alignment,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: _CenterAwareAlign(
                alignment: alignment,
                position: position,
                config: config,
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CenterAwareAlign extends StatelessWidget {
  final Alignment alignment;
  final int position;
  final Widget child;
  final QuickToastConfig config;

  const _CenterAwareAlign({
    required this.alignment,
    required this.position,
    required this.child,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    // For center alignments, wrap in a Column to handle vertical stacking
    if (alignment.y == 0) {
      return Align(
        alignment: alignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PositionedToast(
              position: position,
              alignment: alignment,
              config: config,
              child: child,
            ),
          ],
        ),
      );
    }

    // For non-center alignments, use regular positioning
    return Align(
      alignment: alignment,
      child: _PositionedToast(
        position: position,
        alignment: alignment,
        config: config,
        child: child,
      ),
    );
  }
}

class _PositionedToast extends StatelessWidget {
  final int position;
  final Widget child;
  final Alignment alignment;
  final QuickToastConfig config;

  const _PositionedToast({
    required this.position,
    required this.child,
    required this.alignment,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final margin = config.margin;
    final spacing = position * (config.toastSpacing + 60.0);

    // Calculate vertical offset based on alignment
    final verticalOffset = _calculateVerticalOffset(spacing);
    final horizontalOffset = _calculateHorizontalOffset();

    return Transform.translate(
      offset: Offset(horizontalOffset, verticalOffset),
      child: Padding(
        padding: _calculatePadding(margin),
        child: child,
      ),
    );
  }

  double _calculateVerticalOffset(double spacing) {
    if (alignment.y == 0) {
      // Center alignment - special handling
      if (position == 0) return 0;
      // Move subsequent toasts up from the center
      return -(spacing + 60.0);
    } else if (alignment.y < 0) {
      // Top alignment - move down by spacing
      return spacing;
    } else {
      // Bottom alignment - move up by spacing
      return -spacing;
    }
  }

  double _calculateHorizontalOffset() {
    if (alignment.x == 0) return 0;

    // For center-left/right alignments, add a small offset
    if (alignment.y == 0) {
      return alignment.x < 0 ? 20 : -20;
    }
    return 0;
  }

  EdgeInsets _calculatePadding(EdgeInsets margin) {
    if (alignment.y == 0) {
      // For center alignments, maintain consistent horizontal margins
      return EdgeInsets.symmetric(
        horizontal: margin.left,
        vertical: config.toastSpacing / 2,
      );
    }

    // For other alignments, use the standard margin logic
    return EdgeInsets.only(
      left: margin.left,
      right: margin.right,
      top: alignment.y <= 0 ? margin.top : 0,
      bottom: alignment.y >= 0 ? margin.bottom : 0,
    );
  }
}
