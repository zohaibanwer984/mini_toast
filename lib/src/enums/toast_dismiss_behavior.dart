/// Defines how a toast can be dismissed by the user.
enum ToastDismissBehavior {
  /// Adds a close button to the toast
  button,

  /// Allows dismissing the toast by tapping anywhere on it
  tap,

  /// Disables manual dismissal
  none,
}
