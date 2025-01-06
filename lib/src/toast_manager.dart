import 'dart:collection';
import 'package:flutter/material.dart';
import 'models/toast_data.dart';
import 'models/toast_variant.dart';
import 'widgets/toast_view.dart';
import 'toast_overlay.dart';

const _kDefaultDuration = Duration(seconds: 3);

class ToastManager {
  static final ToastManager instance = ToastManager._();
  ToastManager._();

  final _queue = Queue<ToastData>();
  var _isShowing = false;
  OverlayEntry? _currentEntry;

  void show({
    required String message,
    ToastVariant variant = ToastVariant.info,
    Duration duration = _kDefaultDuration,
  }) {
    _queue.add(ToastData(
      message: message,
      variant: variant,
      duration: duration,
    ));
    _processNextToast();
  }

  void _processNextToast() {
    if (_isShowing || _queue.isEmpty) return;

    final overlayState = _getOverlayState();
    if (overlayState == null) return;

    _isShowing = true;
    final toast = _queue.removeFirst();

    _currentEntry = OverlayEntry(
      builder: (context) => ToastView(
        data: toast,
        onDismiss: _dismissCurrentToast,
      ),
    );

    overlayState.insert(_currentEntry!);

    Future.delayed(toast.duration, _dismissCurrentToast);
  }

  void _dismissCurrentToast() {
    if (_currentEntry?.mounted ?? false) {
      _currentEntry?.remove();
      _currentEntry = null;
      _isShowing = false;
      _processNextToast();
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
