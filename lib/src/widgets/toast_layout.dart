import 'package:flutter/widgets.dart';

import '../configs/quick_toast_config.dart';
import '../enums/toast_position.dart';

class ToastLayout extends StatelessWidget {
  final int position;
  final Widget child;
  final QuickToastConfig config;

  const ToastLayout({
    super.key,
    required this.position,
    required this.child,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: config.alignment,
        child: Padding(
          padding: _calculatePadding(),
          child: Transform.translate(
            offset: _calculateOffset(),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
                minWidth: 200,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Offset _calculateOffset() {
    final spacing = position * (config.toastSpacing + 60.0);
    final isCenter = config.alignment.y == 0;
    final isTop = config.alignment.y < 0;

    double dy;
    if (isCenter) {
      dy = position == 0 ? 0 : -(spacing + 60.0);
    } else {
      dy = isTop ? spacing : -spacing;
    }

    double dx = 0;
    if (config.horizontalPosition == ToastHorizontalPosition.left) {
      dx = 20;
    } else if (config.horizontalPosition == ToastHorizontalPosition.right) {
      dx = -20;
    }

    return Offset(dx, dy);
  }

  EdgeInsets _calculatePadding() {
    final margin = config.margin;
    final isCenter = config.alignment.y == 0;

    if (isCenter) {
      return EdgeInsets.symmetric(
        horizontal: margin.left,
        vertical: config.toastSpacing / 2,
      );
    }

    return EdgeInsets.only(
      left: margin.left,
      right: margin.right,
      top: config.alignment.y <= 0 ? margin.top : 0,
      bottom: config.alignment.y >= 0 ? margin.bottom : 0,
    );
  }
}
