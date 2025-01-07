import 'package:flutter/widgets.dart';

import '../enums/toast_position.dart';
import 'toast_variant.dart';

/// Represents the data required to display a toast notification.
class ToastData {
  /// The message to be displayed in the toast.
  final String message;

  /// The visual style and icon of the toast, such as `info`, `success`, `error`, or `warning`.
  final ToastVariant variant;

  /// The duration for which the toast will remain visible.
  /// Defaults to 3 seconds.
  final Duration duration;

  /// Optional custom text style for the toast message.
  final TextStyle? textStyle;

  /// Optional custom color for the toast icon.
  /// If not provided, defaults to the [ToastVariant]'s text color.
  final Color? iconColor;

  /// The vertical position of the toast on the screen.
  /// Can be `top` or `bottom`.
  final ToastVerticalPosition verticalPosition;

  /// The horizontal position of the toast on the screen.
  /// Can be `left`, `center`, or `right`.
  final ToastHorizontalPosition horizontalPosition;

  /// Creates an instance of [ToastData].
  ///
  /// - [message]: The toast message to be displayed (required).
  /// - [variant]: The visual style of the toast, defaults to `info`.
  /// - [duration]: The duration for which the toast is visible, defaults to 3 seconds.
  /// - [textStyle]: Custom text style for the message (optional).
  /// - [iconColor]: Custom icon color (optional).
  /// - [verticalPosition]: Vertical position of the toast (required).
  /// - [horizontalPosition]: Horizontal position of the toast (required).
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
