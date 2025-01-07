import 'package:flutter/widgets.dart';

import '../enums/toast_position.dart';
import 'toast_variant.dart';

class ToastData {
  final String message;
  final ToastVariant variant;
  final Duration duration;
  final TextStyle? textStyle;
  final Color? iconColor;
  final ToastVerticalPosition verticalPosition;
  final ToastHorizontalPosition horizontalPosition;

  const ToastData({
    required this.message,
    this.variant = ToastVariant.info,
    this.duration = const Duration(seconds: 3),
    this.textStyle,
    this.iconColor,
    required this.verticalPosition,
    required this.horizontalPosition,
  });
}
