import 'package:flutter/widgets.dart';
import 'package:quick_toast/src/configs/quick_toast_config.dart';

import 'toast_variant.dart';

/// Encapsulates the data required to display a toast notification.
///
/// This class holds the message, variant, and duration for a toast,
/// providing a simple structure to manage toast notifications.
///
/// **Usage:**
/// ```dart
/// final toast = ToastData(
///   message: 'Operation successful!',
///   variant: ToastVariant.success,
///   duration: Duration(seconds: 5),
/// );
/// ```
///
/// **Default Values:**
/// - `variant`: [ToastVariant.info]
/// - `duration`: 3 seconds
class ToastData {
  /// The message to be displayed in the toast.
  final String message;

  /// The visual and semantic type of the toast (e.g., success, error, info).
  final ToastVariant variant;

  /// The duration for which the toast will be displayed.
  final Duration duration;

  /// Creates a [ToastData] instance.
  ///
  /// - [message]: Required. The text content of the toast.
  /// - [variant]: Optional. Defaults to [ToastVariant.info].
  /// - [duration]: Optional. Defaults to 3 seconds.
  const ToastData({
    required this.message,
    this.variant = ToastVariant.info,
    this.duration = const Duration(seconds: 3),
    TextStyle? textStyle,
    required Alignment alignment,
    required ToastSlideDirection slideDirection,
  });
}
