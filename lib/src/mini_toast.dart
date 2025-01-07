import 'package:flutter/material.dart';

import 'configs/mini_toast_config.dart';
import 'models/toast_data.dart';
import 'models/toast_variant.dart';
import 'toast_overlay.dart';
import 'widgets/toast_layout.dart';
import 'widgets/toast_view.dart';

/// A singleton class for managing and displaying toast notifications.
///
/// The `MiniToast` class handles the creation, configuration, and lifecycle
/// of toast messages. It uses an [Overlay] to display toasts on top of the current UI.
class MiniToast {
  /// The singleton instance of `MiniToast`.
  static final MiniToast instance = MiniToast._();

  /// Private constructor to prevent external instantiation.
  MiniToast._();

  /// A list of currently active toasts being displayed.
  final List<ActiveToast> _activeToasts = [];

  /// Configuration settings for toasts, which can be customized globally.
  MiniToastConfig _config = const MiniToastConfig();

  /// Updates the global configuration for all toasts.
  void setConfig(MiniToastConfig config) => _config = config;

  /// Displays a toast notification with the given parameters.
  ///
  /// - [message]: The message to display in the toast.
  /// - [variant]: The style variant of the toast (e.g., success, error).
  /// - [displayDuration]: Optional duration to display the toast.
  /// - [textStyle]: Custom text style for the message.
  /// - [iconColor]: Custom color for the icon.
  void show({
    required String message,
    ToastVariant variant = ToastVariant.info,
    Duration? displayDuration,
    TextStyle? textStyle,
    Color? iconColor,
  }) {
    // Get the overlay state to display the toast.
    final overlayState = _getOverlayState();
    if (overlayState == null) return;

    // Create the toast data object with the provided configuration.
    final toastData = ToastData(
      message: message,
      variant: variant,
      duration: displayDuration ?? _config.displayDuration,
      textStyle: textStyle,
      iconColor: iconColor ?? _config.iconColor,
      horizontalPosition: _config.horizontalPosition,
      verticalPosition: _config.verticalPosition,
    );

    // Create an active toast placeholder.
    final toast = ActiveToast(
      data: toastData,
      entry: null, // Placeholder, to be assigned below.
      height: null, // Initially null, measured later.
    );

    // Define the overlay entry for the toast.
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => ToastLayout(
        position: _activeToasts.indexWhere((t) => t.entry == entry),
        config: _config,
        previousToasts: _activeToasts,
        onHeightMeasured: (height) {
          // Update toast height and refresh layout if necessary.
          if (toast.height != height) {
            toast.height = height;
            _activeToasts
                .where((t) => t != toast)
                .forEach((t) => t.entry?.markNeedsBuild());
          }
        },
        child: Material(
          type: MaterialType.transparency,
          child: ToastView(
            data: toastData,
            config: _config,
            onDismiss: () => _removeToast(entry),
          ),
        ),
      ),
    );

    // Assign the overlay entry to the toast and display it.
    toast.entry = entry;
    _activeToasts.add(toast);
    overlayState.insert(entry);

    // Automatically remove the toast after its duration.
    Future.delayed(toastData.duration, () => _removeToast(entry));
  }

  /// Removes a toast from the overlay.
  ///
  /// This method removes the toast's [OverlayEntry] and refreshes the layout
  /// of remaining toasts.
  void _removeToast(OverlayEntry entry) {
    final index = _activeToasts.indexWhere((toast) => toast.entry == entry);
    if (index != -1) {
      entry.remove();
      _activeToasts.removeAt(index);
      for (var toast in _activeToasts) {
        toast.entry?.markNeedsBuild();
      }
    }
  }

  /// Retrieves the [OverlayState] using the global `overlayKey`.
  OverlayState? _getOverlayState() => overlayKey.currentState?.overlayState;
}

/// Represents an active toast currently being displayed.
///
/// This class holds the [ToastData], its [OverlayEntry], and its measured height.
class ActiveToast {
  /// The data defining the toast's content and behavior.
  final ToastData data;

  /// The overlay entry for the toast.
  OverlayEntry? entry;

  /// The measured height of the toast.
  double? height;

  /// Creates an instance of [ActiveToast].
  ActiveToast({
    required this.data,
    required this.entry,
    required this.height,
  });
}
