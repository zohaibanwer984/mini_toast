import 'package:flutter/material.dart';

import '../enums/toast_dismiss_behavior.dart';
import '../utils/toast_position_extension.dart';
import '../enums/toast_position.dart';
import '../enums/toast_slide_direction.dart';

/// Configuration class for customizing the appearance and behavior of toasts in `MiniToast`.
///
/// This class provides various properties to adjust the layout, animations,
/// and visual style of toasts, allowing you to tailor the toast experience to your needs.
class MiniToastConfig {
  /// The text style to apply to the toast message.
  ///
  /// If null, the default text style of the current theme will be used.
  final TextStyle? textStyle;

  /// The vertical position of the toast on the screen.
  ///
  /// Determines whether the toast appears at the top or bottom of the screen.
  /// Defaults to [ToastVerticalPosition.bottom].
  final ToastVerticalPosition verticalPosition;

  /// The horizontal position of the toast on the screen.
  ///
  /// Specifies whether the toast is aligned to the left, center, or right of the screen.
  /// Defaults to [ToastHorizontalPosition.center].
  final ToastHorizontalPosition horizontalPosition;

  /// The direction from which the toast slides into the screen.
  ///
  /// Options include sliding in from the top, bottom, left, or right.
  /// Defaults to [ToastSlideDirection.bottom].
  final ToastSlideDirection slideDirection;

  /// The duration for which the toast remains visible on the screen.
  ///
  /// Defaults to 3 seconds.
  final Duration displayDuration;

  /// The duration of the slide-in and slide-out animations for the toast.
  ///
  /// Defaults to 300 milliseconds.
  final Duration animationDuration;

  /// The spacing between consecutive toasts when multiple toasts are displayed.
  ///
  /// Defaults to 8.0.
  final double toastSpacing;

  /// The margin around the toast widget.
  ///
  /// Defines the space between the toast and the screen edges.
  /// Defaults to `EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0)`.
  final EdgeInsets margin;

  /// The box shadow applied to the toast container.
  ///
  /// Adds depth and visual distinction to the toast widget.
  /// Defaults to a soft black shadow.
  final List<BoxShadow>? boxShadow;

  /// The border radius of the toast container.
  ///
  /// Controls the roundness of the toast's corners.
  /// Defaults to `BorderRadius.circular(8.0)`.
  final BorderRadius borderRadius;

  /// The padding applied to the content inside the toast container.
  ///
  /// Determines the space around the message text and icon within the toast.
  /// Defaults to `EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)`.
  final EdgeInsets contentPadding;

  /// The color of the icon displayed within the toast, if any.
  ///
  /// If null, the default color based on the toast's theme or variant is used.
  final Color? iconColor;

  /// Determines how the toast can be dismissed by the user.
  final ToastDismissBehavior dismissBehavior;

  /// The color of the close button (if shown).
  final Color? closeButtonColor;

  /// Creates a new instance of `MiniToastConfig` with customizable properties.
  ///
  /// Example:
  /// ```dart
  /// MiniToastConfig(
  ///   verticalPosition: ToastVerticalPosition.top,
  ///   horizontalPosition: ToastHorizontalPosition.right,
  ///   slideDirection: ToastSlideDirection.left,
  ///   textStyle: TextStyle(fontSize: 16, color: Colors.white),
  ///   boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
  /// );
  /// ```
  const MiniToastConfig({
    this.textStyle,
    this.verticalPosition = ToastVerticalPosition.bottom,
    this.horizontalPosition = ToastHorizontalPosition.center,
    this.slideDirection = ToastSlideDirection.bottom,
    this.displayDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 300),
    this.toastSpacing = 8.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
    this.boxShadow = const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 6,
        offset: Offset(0, 3),
      ),
    ],
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ),
    this.iconColor,
    this.dismissBehavior = ToastDismissBehavior.none,
    this.closeButtonColor,
  });

  /// Returns the alignment of the toast based on its vertical and horizontal positions.
  ///
  /// This property uses the [ToastVerticalPosition] and [ToastHorizontalPosition]
  /// enums to calculate the appropriate alignment for the toast.
  Alignment get alignment => Alignment(
        horizontalPosition.alignmentX,
        verticalPosition.alignmentY,
      );

  /// Creates a copy of the current configuration with overridden properties.
  ///
  /// This method allows you to modify specific properties while retaining the rest.
  /// Example:
  /// ```dart
  /// final updatedConfig = defaultConfig.copyWith(
  ///   verticalPosition: ToastVerticalPosition.top,
  ///   margin: EdgeInsets.all(10),
  /// );
  /// ```
  MiniToastConfig copyWith({
    TextStyle? textStyle,
    ToastVerticalPosition? verticalPosition,
    ToastHorizontalPosition? horizontalPosition,
    ToastSlideDirection? slideDirection,
    Duration? displayDuration,
    Duration? animationDuration,
    double? toastSpacing,
    EdgeInsets? margin,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    EdgeInsets? contentPadding,
    Color? iconColor,
    ToastDismissBehavior? dismissBehavior,
    Color? closeButtonColor,
  }) {
    return MiniToastConfig(
      textStyle: textStyle ?? this.textStyle,
      verticalPosition: verticalPosition ?? this.verticalPosition,
      horizontalPosition: horizontalPosition ?? this.horizontalPosition,
      slideDirection: slideDirection ?? this.slideDirection,
      displayDuration: displayDuration ?? this.displayDuration,
      animationDuration: animationDuration ?? this.animationDuration,
      toastSpacing: toastSpacing ?? this.toastSpacing,
      margin: margin ?? this.margin,
      boxShadow: boxShadow ?? this.boxShadow,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      iconColor: iconColor ?? this.iconColor,
      dismissBehavior: dismissBehavior ?? this.dismissBehavior,
      closeButtonColor: closeButtonColor ?? this.closeButtonColor,
    );
  }
}
