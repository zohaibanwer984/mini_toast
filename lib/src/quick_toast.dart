import 'package:flutter/material.dart';

import 'configs/quick_toast_config.dart';
import 'models/toast_data.dart';
import 'models/toast_variant.dart';
import 'toast_overlay.dart';
import 'widgets/toast_layout.dart';
import 'widgets/toast_view.dart';

class QuickToast {
  static final QuickToast instance = QuickToast._();
  QuickToast._();

  final List<ActiveToast> _activeToasts = [];
  QuickToastConfig _config = const QuickToastConfig();

  void setConfig(QuickToastConfig config) => _config = config;

  void show({
    required String message,
    ToastVariant variant = ToastVariant.info,
    Duration? displayDuration,
    TextStyle? textStyle,
    Color? iconColor,
  }) {
    final overlayState = _getOverlayState();
    if (overlayState == null) return;

    final toastData = ToastData(
      message: message,
      variant: variant,
      duration: displayDuration ?? _config.displayDuration,
      textStyle: textStyle,
      iconColor: iconColor ?? _config.iconColor,
      horizontalPosition: _config.horizontalPosition,
      verticalPosition: _config.verticalPosition,
    );

    final toast = ActiveToast(
      data: toastData,
      entry: null, // Will be set below
      height: null, // Initially null, will be measured
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => ToastLayout(
        position: _activeToasts.indexWhere((t) => t.entry == entry),
        config: _config,
        previousToasts: _activeToasts,
        onHeightMeasured: (height) {
          if (toast.height != height) {
            toast.height = height;
            _activeToasts
                .where((t) => t != toast)
                .forEach((t) => t.entry?.markNeedsBuild());
          }
        },
        child: Material(
          type: MaterialType.transparency,
          child: ToastView(
            data: toastData,
            config: _config,
            onDismiss: () => _removeToast(entry),
          ),
        ),
      ),
    );

    toast.entry = entry;
    _activeToasts.add(toast);
    overlayState.insert(entry);

    Future.delayed(toastData.duration, () => _removeToast(entry));
  }

  void _removeToast(OverlayEntry entry) {
    final index = _activeToasts.indexWhere((toast) => toast.entry == entry);
    if (index != -1) {
      entry.remove();
      _activeToasts.removeAt(index);
      for (var toast in _activeToasts) {
        toast.entry?.markNeedsBuild();
      }
    }
  }

  OverlayState? _getOverlayState() => overlayKey.currentState?.overlayState;
}

class ActiveToast {
  final ToastData data;
  OverlayEntry? entry;
  double? height;

  ActiveToast({
    required this.data,
    required this.entry,
    required this.height,
  });
}
