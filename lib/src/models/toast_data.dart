import 'toast_variant.dart';

const _kDefaultDuration = Duration(seconds: 3);

class ToastData {
  final String message;
  final ToastVariant variant;
  final Duration duration;

  const ToastData({
    required this.message,
    this.variant = ToastVariant.info,
    this.duration = _kDefaultDuration,
  });
}