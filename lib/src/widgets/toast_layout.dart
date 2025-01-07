import 'package:flutter/widgets.dart';

import '../quick_toast.dart';
import '../configs/quick_toast_config.dart';
import '../enums/toast_position.dart';

class ToastLayout extends StatelessWidget {
  final int position;
  final Widget child;
  final QuickToastConfig config;
  final List<ActiveToast> previousToasts;
  final ValueChanged<double> onHeightMeasured;

  const ToastLayout({
    super.key,
    required this.position,
    required this.child,
    required this.config,
    required this.previousToasts,
    required this.onHeightMeasured,
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
              child: _MeasureSize(
                onChange: onHeightMeasured,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Offset _calculateOffset() {
    double totalOffset = 0;

    // Calculate offset based on previous toasts' actual heights
    for (int i = 0; i < position; i++) {
      final previousHeight =
          previousToasts[i].height ?? 60.0; // fallback height
      totalOffset += previousHeight + config.toastSpacing;
    }

    final isCenter = config.alignment.y == 0;
    final isTop = config.alignment.y < 0;

    double dy;
    if (isCenter) {
      dy = position == 0 ? 0 : -(totalOffset);
    } else {
      dy = isTop ? totalOffset : -totalOffset;
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

// Add this new widget to measure sizes
class _MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<double> onChange;

  const _MeasureSize({
    required this.child,
    required this.onChange,
  });

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<_MeasureSize> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureSize());
  }

  void _measureSize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;

    final size = context.size;
    if (size == null || _oldSize == size) return;

    _oldSize = size;
    widget.onChange(size.height);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _widgetKey,
      child: widget.child,
    );
  }
}
