import 'package:flutter/material.dart';

final overlayKey = GlobalKey<ToastOverlayState>(debugLabel: 'toast_overlay');

class ToastOverlayWrapper extends StatelessWidget {
  final Widget child;

  const ToastOverlayWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) => _ToastOverlay(child: child);
}

class _ToastOverlay extends StatefulWidget {
  final Widget child;

  _ToastOverlay({required this.child}) : super(key: overlayKey);

  @override
  ToastOverlayState createState() => _ToastOverlayState();
}

abstract class ToastOverlayState<T extends StatefulWidget> extends State<T> {
  OverlayState? get overlayState;
}

class _ToastOverlayState extends ToastOverlayState<_ToastOverlay> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  OverlayState? get overlayState {
    NavigatorState? navigator;

    void visitor(Element element) {
      if (navigator != null) return;
      if (element.widget is Navigator) {
        navigator = (element as StatefulElement).state as NavigatorState?;
      } else {
        element.visitChildElements(visitor);
      }
    }

    context.visitChildElements(visitor);
    return navigator?.overlay;
  }
}
