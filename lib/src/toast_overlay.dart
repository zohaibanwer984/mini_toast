import 'package:flutter/material.dart';

final overlayKey = GlobalKey<ToastOverlayState>(debugLabel: 'toast_overlay');

/// A wrapper widget that provides an overlay for displaying toast notifications.
///
/// The [ToastOverlayWrapper] is designed to wrap the application's root widget
/// (e.g., `MaterialApp`). It integrates an [Overlay] to allow toasts to be displayed
/// above the current UI.
///
/// **Usage:**
/// ```dart
/// void main() {
///   runApp(
///     ToastOverlayWrapper(
///       child: MaterialApp(
///         home: MyHomePage(),
///       ),
///     ),
///   );
/// }
/// ```
///
/// Use the global `overlayKey` to access the [ToastOverlayState] and display toasts.
class ToastOverlayWrapper extends StatelessWidget {
  /// The child widget to be wrapped, typically the app's root widget.
  final Widget child;

  /// Creates a [ToastOverlayWrapper].
  ///
  /// - [child]: The widget that will be wrapped.
  const ToastOverlayWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) => _ToastOverlay(child: child);
}

/// A private [StatefulWidget] that manages the overlay for toasts.
///
/// This widget is internal to the library and should not be used directly.
class _ToastOverlay extends StatefulWidget {
  /// The child widget to be displayed under the overlay.
  final Widget child;

  /// Creates a [_ToastOverlay] with the specified child.
  _ToastOverlay({required this.child}) : super(key: overlayKey);

  @override
  ToastOverlayState createState() => _ToastOverlayState();
}

/// Abstract class defining the state for a toast overlay.
///
/// This class provides the [overlayState] getter for accessing the
/// overlay associated with the current context.
abstract class ToastOverlayState<T extends StatefulWidget> extends State<T> {
  /// The [OverlayState] for the current overlay.
  ///
  /// Returns `null` if no overlay is found.
  OverlayState? get overlayState;
}

/// Implementation of [ToastOverlayState] for managing the toast overlay.
///
/// This class uses the [Navigator] widget in the widget tree to locate
/// and return the [OverlayState].
class _ToastOverlayState extends ToastOverlayState<_ToastOverlay> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  OverlayState? get overlayState {
    NavigatorState? navigator;

    // Helper method to traverse the widget tree and locate the Navigator.
    void visitor(Element element) {
      if (navigator != null) return;
      if (element.widget is Navigator) {
        navigator = (element as StatefulElement).state as NavigatorState?;
      } else {
        element.visitChildElements(visitor);
      }
    }

    // Begin traversal from the current context.
    context.visitChildElements(visitor);
    return navigator?.overlay;
  }
}
