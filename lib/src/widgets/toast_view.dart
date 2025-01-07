import 'package:flutter/widgets.dart';

import '../configs/quick_toast_config.dart';
import '../models/toast_data.dart';
import '../utils/toast_slide_extension.dart';

/// A widget that represents a single toast notification.
///
/// The `ToastView` animates into view using a slide and fade effect and
/// displays the content of the toast based on the provided configuration and data.
///
/// **Key Features:**
/// - Slide and fade animations.
/// - Customizable appearance based on `ToastData` and `QuickToastConfig`.
/// - Automatically dismisses itself when animation completes.
///
/// This widget is used internally by the QuickToast library.
class ToastView extends StatefulWidget {
  /// The data that defines the content and style of the toast.
  final ToastData data;

  /// The configuration for the toast's appearance and behavior.
  final QuickToastConfig config;

  /// Callback invoked when the toast is dismissed.
  final VoidCallback onDismiss;

  /// Creates a [ToastView] with the given data and configuration.
  const ToastView({
    super.key,
    required this.data,
    required this.config,
    required this.onDismiss,
  });

  @override
  State<ToastView> createState() => _ToastViewState();
}

/// The state for [ToastView], managing its animations and lifecycle.
class _ToastViewState extends State<ToastView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with the configured duration.
    _controller = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );

    // Set up fade animation from transparent to visible.
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Set up slide animation based on the slide direction.
    _slideAnimation = Tween<Offset>(
      begin: widget.config.slideDirection.initialOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation when the widget is initialized.
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
            maxWidth: 400, // Maximum width for the toast.
            minWidth: 200, // Minimum width for the toast.
          ),
          child: IntrinsicWidth(
            child: Container(
              padding: widget.config.contentPadding,
              decoration: BoxDecoration(
                color: widget.data.variant.backgroundColor,
                borderRadius: widget.config.borderRadius,
                boxShadow: widget.config.boxShadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon for the toast.
                  Icon(
                    widget.data.variant.iconData,
                    color: widget.data.iconColor ??
                        widget.config.iconColor ??
                        widget.data.variant.textColor,
                  ),
                  const SizedBox(width: 8),
                  // Text message of the toast.
                  Text(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the animation controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
}
