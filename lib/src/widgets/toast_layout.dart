import 'package:flutter/widgets.dart';

import '../quick_toast.dart';
import '../configs/quick_toast_config.dart';
import '../enums/toast_position.dart';

/// A layout widget for positioning and managing the display of toast notifications.
///
/// The `ToastLayout` calculates the appropriate offset and padding for each toast
/// based on its position in the stack and the configuration provided. It also measures
/// the height of its child widget to assist in dynamic positioning of subsequent toasts.
class ToastLayout extends StatelessWidget {
  /// The position of the toast in the stack of active toasts.
  final int position;

  /// The child widget representing the toast content.
  final Widget child;

  /// Configuration for the toast's appearance and layout.
  final QuickToastConfig config;

  /// A list of active toasts that precede this one.
  final List<ActiveToast> previousToasts;

  /// Callback to notify the measured height of the toast.
  final ValueChanged<double> onHeightMeasured;

  /// Creates a [ToastLayout] with the given parameters.
  const ToastLayout({
    super.key,
    required this.position,
    required this.child,
    required this.config,
    required this.previousToasts,
    required this.onHeightMeasured,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: config.alignment,
        child: Padding(
          padding: _calculatePadding(),
          child: Transform.translate(
            offset: _calculateOffset(),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400, // Maximum width for the toast
                minWidth: 200, // Minimum width for the toast
              ),
              child: _MeasureSize(
                onChange: onHeightMeasured,
                child: Container(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Calculates the offset for the toast based on its position and previous toasts' heights.
  Offset _calculateOffset() {
    double totalOffset = 0;

    // Accumulate the total height of previous toasts with spacing.
    for (int i = 0; i < position; i++) {
      final previousHeight =
          previousToasts[i].height ?? 60.0; // Fallback height if not measured.
      totalOffset += previousHeight + config.toastSpacing;
    }

    final isCenter = config.alignment.y == 0;
    final isTop = config.alignment.y < 0;

    double dy;
    if (isCenter) {
      dy = position == 0 ? 0 : -(totalOffset);
    } else {
      dy = isTop ? totalOffset : -totalOffset;
    }

    double dx = 0;
    if (config.horizontalPosition == ToastHorizontalPosition.left) {
      dx = 20; // Offset for left alignment
    } else if (config.horizontalPosition == ToastHorizontalPosition.right) {
      dx = -20; // Offset for right alignment
    }

    return Offset(dx, dy);
  }

  /// Calculates padding for the toast based on its alignment and margin configuration.
  EdgeInsets _calculatePadding() {
    final margin = config.margin;
    final isCenter = config.alignment.y == 0;

    if (isCenter) {
      return EdgeInsets.symmetric(
        horizontal: margin.left,
        vertical: config.toastSpacing / 2,
      );
    }

    return EdgeInsets.only(
      left: margin.left,
      right: margin.right,
      top: config.alignment.y <= 0 ? margin.top : 0,
      bottom: config.alignment.y >= 0 ? margin.bottom : 0,
    );
  }
}

/// A widget that measures the size of its child and notifies when the size changes.
///
/// This is useful for dynamically determining the height of toast widgets to adjust
/// their layout accordingly.
class _MeasureSize extends StatefulWidget {
  /// The child widget whose size is to be measured.
  final Widget child;

  /// Callback to notify the height of the child widget.
  final ValueChanged<double> onChange;

  /// Creates a [_MeasureSize] widget.
  const _MeasureSize({
    required this.child,
    required this.onChange,
  });

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

/// State for [_MeasureSize], responsible for measuring the size of its child widget.
class _MeasureSizeState extends State<_MeasureSize> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureSize());
  }

  /// Measures the size of the child widget and notifies if it has changed.
  void _measureSize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;

    final size = context.size;
    if (size == null || _oldSize == size) return;

    _oldSize = size;
    widget.onChange(size.height);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _widgetKey,
      child: widget.child,
    );
  }
}
