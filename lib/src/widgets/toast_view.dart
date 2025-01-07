import 'package:flutter/widgets.dart';

import '../../quick_toast.dart';

class ToastView extends StatefulWidget {
  final ToastData data;
  final QuickToastConfig config;
  final VoidCallback onDismiss;

  const ToastView({
    super.key,
    required this.data,
    required this.config,
    required this.onDismiss,
  });

  @override
  State<ToastView> createState() => _ToastViewState();
}

class _ToastViewState extends State<ToastView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: widget.config.slideDirection.initialOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacity,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400, // Maximum width for the toast
            minWidth: 200, // Minimum width for the toast
          ),
          child: IntrinsicWidth(
            child: Container(
              padding: widget.config.contentPadding,
              decoration: BoxDecoration(
                color: widget.data.variant.backgroundColor,
                borderRadius: widget.config.borderRadius,
                boxShadow: widget.config.boxShadow,
              ),
              child: Text(
                widget.data.message,
                style: widget.config.textStyle?.copyWith(
                      color: widget.data.variant.textColor,
                    ) ??
                    TextStyle(
                      color: widget.data.variant.textColor,
                      fontSize: 16,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
