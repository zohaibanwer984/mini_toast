import 'package:flutter/material.dart';

import '../utils/toast_position_extension.dart';
import '../enums/toast_position.dart';
import '../enums/toast_slide_direction.dart';

class QuickToastConfig {
  final TextStyle? textStyle;
  final ToastVerticalPosition verticalPosition;
  final ToastHorizontalPosition horizontalPosition;
  final ToastSlideDirection slideDirection;
  final Duration displayDuration;
  final Duration animationDuration;
  final double toastSpacing;
  final EdgeInsets margin;
  final List<BoxShadow>? boxShadow;
  final BorderRadius borderRadius;
  final EdgeInsets contentPadding;

  const QuickToastConfig({
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
  });

  Alignment get alignment => Alignment(
        horizontalPosition.alignmentX,
        verticalPosition.alignmentY,
      );

  QuickToastConfig copyWith({
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
  }) {
    return QuickToastConfig(
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
    );
  }
}
