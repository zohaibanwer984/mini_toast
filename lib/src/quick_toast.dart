import 'package:flutter/widgets.dart';

import 'configs/quick_toast_config.dart';
import 'models/toast_data.dart';
import 'models/toast_variant.dart';
import 'toast_overlay.dart';
import 'widgets/toast_layout.dart';
import 'widgets/toast_view.dart';

class QuickToast {
  static final QuickToast instance = QuickToast._();
  QuickToast._();

  final List<_ActiveToast> _activeToasts = [];
  QuickToastConfig _config = const QuickToastConfig();

  void setConfig(QuickToastConfig config) => _config = config;

  void show({
    required String message,
    ToastVariant variant = ToastVariant.info,
    Duration? displayDuration,
    TextStyle? textStyle,
  }) {
    final overlayState = _getOverlayState();
    if (overlayState == null) return;

    final toastData = ToastData(
      message: message,
      variant: variant,
      duration: displayDuration ?? _config.displayDuration,
      textStyle: textStyle,
      horizontalPosition: _config.horizontalPosition,
      verticalPosition: _config.verticalPosition,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => ToastLayout(
        position: _activeToasts.indexWhere((t) => t.entry == entry),
        config: _config,
        child: ToastView(
          data: toastData,
          config: _config,
          onDismiss: () => _removeToast(entry),
        ),
      ),
    );

    _activeToasts.add(_ActiveToast(data: toastData, entry: entry));
    overlayState.insert(entry);

    Future.delayed(toastData.duration, () => _removeToast(entry));
  }

  void _removeToast(OverlayEntry entry) {
    final index = _activeToasts.indexWhere((toast) => toast.entry == entry);
    if (index != -1) {
      entry.remove();
      _activeToasts.removeAt(index);
      for (var toast in _activeToasts) {
        toast.entry.markNeedsBuild();
      }
    }
  }

  OverlayState? _getOverlayState() => overlayKey.currentState?.overlayState;
}

class _ActiveToast {
  final ToastData data;
  final OverlayEntry entry;

  _ActiveToast({required this.data, required this.entry});
}
