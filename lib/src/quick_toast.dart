import 'package:flutter/material.dart';
import 'models/toast_data.dart';
import 'models/toast_variant.dart';
import 'widgets/toast_view.dart';
import 'toast_overlay.dart';

const _kDefaultDuration = Duration(seconds: 3);
const _kToastSpacing = 8.0;
const _kBottomMargin = 50.0;

class ActiveToast {
  final ToastData data;
  final OverlayEntry entry;

  ActiveToast({
    required this.data,
    required this.entry,
  });
}

class QuickToast {
  static final QuickToast instance = QuickToast._();
  QuickToast._();

  final List<ActiveToast> _activeToasts = [];

  void show({
    required String message,
    ToastVariant variant = ToastVariant.info,
    Duration duration = _kDefaultDuration,
  }) {
    final overlayState = _getOverlayState();
    if (overlayState == null) return;

    final toastData = ToastData(
      message: message,
      variant: variant,
      duration: duration,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) {
        final index = _activeToasts.indexWhere((t) => t.entry == entry);
        return _ToastPosition(
          position: index,
          child: ToastView(
            data: toastData,
            onDismiss: () => _removeToast(entry),
          ),
        );
      },
    );

    final activeToast = ActiveToast(
      data: toastData,
      entry: entry,
    );

    _activeToasts.add(activeToast);
    overlayState.insert(entry);

    // Schedule removal after duration
    Future.delayed(duration, () {
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

  const _ToastPosition({
    required this.position,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate position from bottom, stacking toasts upward
    final bottom = _kBottomMargin + (position * (_kToastSpacing + 60.0));

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      bottom: bottom,
      left: 20,
      right: 20,
      child: child,
    );
  }
}
