import 'package:flutter/widgets.dart';

import '../configs/mini_toast_config.dart';
import '../models/toast_data.dart';
import '../utils/toast_slide_extension.dart';

/// A widget that represents a single toast notification.
///
/// The `ToastView` animates into view using a slide and fade effect and
/// displays the content of the toast based on the provided configuration and data.
///
/// **Key Features:**
/// - Slide and fade animations.
/// - Customizable appearance based on `ToastData` and `MiniToastConfig`.
/// - Supports custom content.
/// - Automatically dismisses itself when animation completes.
///
/// This widget is used internally by the MiniToast library.
class ToastView extends StatefulWidget {
  /// The data that defines the content and style of the toast.
  final ToastData data;

  /// The configuration for the toast's appearance and behavior.
  final MiniToastConfig config;

  /// The Widget for custom toast content.
  final Widget? customContent;

  /// The Decoration for custom toast container
  final Decoration? decoration;

  /// Callback invoked when the toast is dismissed.
  final VoidCallback onDismiss;

  /// Creates a [ToastView] with the given data and configuration.
  const ToastView({
    super.key,
    required this.data,
    required this.config,
    required this.onDismiss,
    this.customContent,
    this.decoration,
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

    // Initialize the animation controller with the configured duration.
    _controller = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );

    // Set up fade animation from transparent to visible.
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

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
        child: Container(
          padding: widget.config.contentPadding,
          decoration: widget.decoration ??
              BoxDecoration(
                color: widget.data.variant.backgroundColor,
                borderRadius: widget.config.borderRadius,
                boxShadow: widget.config.boxShadow,
              ),
          child: widget.customContent != null
              ? IntrinsicHeight(
                  child: widget.customContent,
                )
              : Row(
                  mainAxisSize:
                      MainAxisSize.min, // Ensures the row takes minimum space.
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.data.variant.iconData,
                      color: widget.data.iconColor ??
                          widget.config.iconColor ??
                          widget.data.variant.textColor,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
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
                  ],
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
