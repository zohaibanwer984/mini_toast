import 'package:flutter/material.dart';
import '../models/toast_data.dart';

const _kAnimationDuration = Duration(milliseconds: 300);
const _kToastBottomMargin = 50.0;
const _kToastHorizontalMargin = 20.0;

class ToastView extends StatelessWidget {
  final ToastData data;
  final VoidCallback onDismiss;

  const ToastView({
    super.key,
    required this.data,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _kToastBottomMargin,
      left: _kToastHorizontalMargin,
      right: _kToastHorizontalMargin,
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          duration: _kAnimationDuration,
          opacity: 1.0,
          onEnd: onDismiss,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: data.variant.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              data.message,
              style: TextStyle(
                color: data.variant.textColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
