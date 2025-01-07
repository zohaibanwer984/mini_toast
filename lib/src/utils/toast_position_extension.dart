import '../enums/toast_position.dart';

/// Extension on [ToastVerticalPosition] to provide alignment utilities.
extension ToastPositionExtension on ToastVerticalPosition {
  /// Gets the vertical alignment value for positioning.
  ///
  /// - [ToastVerticalPosition.top]: Aligns to the top (-1.0).
  /// - [ToastVerticalPosition.bottom]: Aligns to the bottom (1.0).
  double get alignmentY {
    switch (this) {
      case ToastVerticalPosition.top:
        return -1.0; // Aligns to the top
      case ToastVerticalPosition.bottom:
        return 1.0; // Aligns to the bottom
    }
  }
}

/// Extension on [ToastHorizontalPosition] to provide alignment utilities.
extension ToastHorizontalPositionExtension on ToastHorizontalPosition {
  /// Gets the horizontal alignment value for positioning.
  ///
  /// - [ToastHorizontalPosition.left]: Aligns to the left (-1.0).
  /// - [ToastHorizontalPosition.center]: Aligns to the center (0.0).
  /// - [ToastHorizontalPosition.right]: Aligns to the right (1.0).
  double get alignmentX {
    switch (this) {
      case ToastHorizontalPosition.left:
        return -1.0; // Aligns to the left
      case ToastHorizontalPosition.center:
        return 0.0; // Aligns to the center
      case ToastHorizontalPosition.right:
        return 1.0; // Aligns to the right
    }
  }
}
