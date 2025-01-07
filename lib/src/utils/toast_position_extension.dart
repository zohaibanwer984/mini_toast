import '../enums/toast_position.dart';

extension ToastPositionExtension on ToastVerticalPosition {
  double get alignmentY {
    switch (this) {
      case ToastVerticalPosition.top:
        return -1.0;
      case ToastVerticalPosition.bottom:
        return 1.0;
    }
  }
}

extension ToastHorizontalPositionExtension on ToastHorizontalPosition {
  double get alignmentX {
    switch (this) {
      case ToastHorizontalPosition.left:
        return -1.0;
      case ToastHorizontalPosition.center:
        return 0.0;
      case ToastHorizontalPosition.right:
        return 1.0;
    }
  }
}
