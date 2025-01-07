import 'package:flutter/material.dart';

/// Defines the direction from which the toast will slide in
enum ToastSlideDirection {
  left,
  right,
  top,
  bottom,
}

/// Global configuration for QuickToast
class QuickToastConfig {
  /// Default text style for all toasts
  final TextStyle? textStyle;

  /// Default position for toasts
  final Alignment alignment;

  /// Direction from which toasts slide in
  final ToastSlideDirection slideDirection;

  /// Default duration for which toasts are shown
  final Duration displayDuration;

  /// Duration of the slide/fade animations
  final Duration animationDuration;

  /// Spacing between multiple toasts
  final double toastSpacing;

  /// Margin from the edges of the screen
  final EdgeInsets margin;

  /// Shadow configuration for toast containers
  final List<BoxShadow>? boxShadow;

  /// Border radius for toast containers
  final BorderRadius borderRadius;

  /// Padding inside toast containers
  final EdgeInsets contentPadding;

  const QuickToastConfig({
    this.textStyle,
    this.alignment = Alignment.bottomCenter,
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
  });

  /// Creates a copy of this config with the given fields replaced with new values
  QuickToastConfig copyWith({
    TextStyle? textStyle,
    Alignment? alignment,
    ToastSlideDirection? slideDirection,
    Duration? displayDuration,
    Duration? animationDuration,
    double? toastSpacing,
    EdgeInsets? margin,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    EdgeInsets? contentPadding,
  }) {
    return QuickToastConfig(
      textStyle: textStyle ?? this.textStyle,
      alignment: alignment ?? this.alignment,
      slideDirection: slideDirection ?? this.slideDirection,
      displayDuration: displayDuration ?? this.displayDuration,
      animationDuration: animationDuration ?? this.animationDuration,
      toastSpacing: toastSpacing ?? this.toastSpacing,
      margin: margin ?? this.margin,
      boxShadow: boxShadow ?? this.boxShadow,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }
}

/// Extension to get initial offset based on slide direction
extension ToastSlideDirectionExtension on ToastSlideDirection {
  Offset get initialOffset {
    switch (this) {
      case ToastSlideDirection.left:
        return const Offset(-1.0, 0.0);
      case ToastSlideDirection.right:
        return const Offset(1.0, 0.0);
      case ToastSlideDirection.top:
        return const Offset(0.0, -1.0);
      case ToastSlideDirection.bottom:
        return const Offset(0.0, 1.0);
    }
  }
}
