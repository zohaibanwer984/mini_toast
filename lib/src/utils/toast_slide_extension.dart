import 'package:flutter/animation.dart';

import '../enums/toast_slide_direction.dart';

extension ToastSlideDirectionExtension on ToastSlideDirection {
  Offset get initialOffset {
    switch (this) {
      case ToastSlideDirection.left:
        return const Offset(-1.0, 0.0);
      case ToastSlideDirection.right:
        return const Offset(1.0, 0.0);
      case ToastSlideDirection.top:
        return const Offset(0.0, -1.0);
      case ToastSlideDirection.bottom:
        return const Offset(0.0, 1.0);
    }
  }
}
