import 'package:flutter/animation.dart';

import '../enums/toast_slide_direction.dart';

/// Extension on [ToastSlideDirection] to provide utility methods for slide animations.
extension ToastSlideDirectionExtension on ToastSlideDirection {
  /// Gets the initial offset for the slide animation based on the direction.
  ///
  /// This offset determines the starting position of the toast animation
  /// relative to its final position.
  ///
  /// - [ToastSlideDirection.left]: Starts from the left.
  /// - [ToastSlideDirection.right]: Starts from the right.
  /// - [ToastSlideDirection.top]: Starts from the top.
  /// - [ToastSlideDirection.bottom]: Starts from the bottom.
  Offset get initialOffset {
    switch (this) {
      case ToastSlideDirection.left:
        return const Offset(-1.0, 0.0); // Slide in from the left
      case ToastSlideDirection.right:
        return const Offset(1.0, 0.0); // Slide in from the right
      case ToastSlideDirection.top:
        return const Offset(0.0, -1.0); // Slide in from the top
      case ToastSlideDirection.bottom:
        return const Offset(0.0, 1.0); // Slide in from the bottom
    }
  }
}
