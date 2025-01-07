import 'package:flutter/material.dart';

/// A global key used to access the [ToastOverlayState].
final overlayKey = GlobalKey<ToastOverlayState>(debugLabel: 'toast_overlay');

/// A wrapper widget that provides an overlay for displaying toast notifications.
///
/// This widget wraps the application's root widget (e.g., `MaterialApp`) and
/// integrates an [Overlay] for displaying toast messages above the UI.
///
/// **Usage Example:**
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
/// Use the global `overlayKey` to access the [ToastOverlayState] for displaying toasts.
class ToastOverlayWrapper extends StatelessWidget {
  /// The child widget to be wrapped, typically the app's root widget.
  final Widget child;

  /// Creates a [ToastOverlayWrapper].
  const ToastOverlayWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) => _ToastOverlay(child: child);
}

/// A private [StatefulWidget] that manages the overlay for toasts.
///
/// This is an internal widget and should not be used directly.
class _ToastOverlay extends StatefulWidget {
  /// The child widget displayed beneath the overlay.
  final Widget child;

  /// Creates a [_ToastOverlay] with the specified child.
  _ToastOverlay({required this.child}) : super(key: overlayKey);

  @override
  ToastOverlayState createState() => _ToastOverlayState();
}

/// Abstract class defining the state for a toast overlay.
///
/// This provides access to the [OverlayState] for the overlay in the current context.
abstract class ToastOverlayState<T extends StatefulWidget> extends State<T> {
  /// Returns the [OverlayState] for the current overlay, or `null` if not found.
  OverlayState? get overlayState;
}

/// Implementation of [ToastOverlayState] for managing the toast overlay.
///
/// This locates the [OverlayState] using the widget tree, specifically
/// through the [Navigator] widget.
class _ToastOverlayState extends ToastOverlayState<_ToastOverlay> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  OverlayState? get overlayState {
    NavigatorState? navigator;

    // Helper function to locate the Navigator widget in the tree.
    void visitor(Element element) {
      if (navigator != null) return;
      if (element.widget is Navigator) {
        navigator = (element as StatefulElement).state as NavigatorState?;
      } else {
        element.visitChildElements(visitor);
      }
    }

    // Start traversal from the current context.
    context.visitChildElements(visitor);
    return navigator?.overlay;
  }
}
