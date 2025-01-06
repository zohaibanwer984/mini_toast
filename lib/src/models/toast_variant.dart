import 'package:flutter/material.dart';

enum ToastVariant {
  success(backgroundColor: Colors.green, textColor: Colors.white),
  error(backgroundColor: Colors.red, textColor: Colors.white),
  info(backgroundColor: Colors.blue, textColor: Colors.white);

  final Color backgroundColor;
  final Color textColor;

  const ToastVariant({
    required this.backgroundColor,
    required this.textColor,
  });
}
