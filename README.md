![DEMO IMAGE](./demo.gif)
# MiniToast 🍞

A lightweight, flexible toast notification library for Flutter that automatically handles varying content sizes and provides smooth animations. MiniToast makes it simple to display beautiful, stacked notifications in your Flutter apps with minimal setup.

## ✨ Features

- 🎯 **Smart Positioning**: Automatically handles varying toast heights and stacks them properly
- 🎨 **Variants with Icons**: 
  - 🟢 Success toasts with check icon
  - 🔴 Error toasts with cancel icon
  - 🔵 Info toasts with info icon
- 📐 **Flexible Placement**:
  - Vertical: Top or bottom
  - Horizontal: Left, center, or right
- ⚡ **Smooth Animations**: 
  - Fade in/out
  - Customizable slide directions
- 🎛️ **Rich Customization**:
  - Duration control
  - Custom text styles
  - Icon colors
  - Spacing and margins
  - Shadow and border radius
- 📦 **Simple Integration**: Just wrap your app and start showing toasts

## 📦 Installation

Add MiniToast to your `pubspec.yaml`:
```yaml
dependencies:
  mini_toast: ^1.0.0
```

## 🚀 Usage

### 1. Wrap Your App

First, wrap your app with `ToastOverlayWrapper`:

```dart
void main() {
  runApp(
    ToastOverlayWrapper(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
```

### 2. Show Toasts

Use the `MiniToast.instance` to display toasts:

```dart
// Success toast
MiniToast.instance.show(
  message: 'Operation completed successfully!',
  variant: ToastVariant.success,
);

// Error toast
MiniToast.instance.show(
  message: 'Something went wrong',
  variant: ToastVariant.error,
);

// Info toast
MiniToast.instance.show(
  message: 'New message received',
  variant: ToastVariant.info,
);

// Custom toast
MiniToast.instance.showCustom(
  decoration: BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(8),
  ),
  builder: (context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.star, color: Colors.white),
      const SizedBox(width: 8),
      Text(
        'Custom Toast!',
        style: TextStyle(color: Colors.white),
      ),
    ],
  ),
  displayDuration: Duration(seconds: 5),
);
```

### 3. Customize Appearance

Configure global toast settings:

```dart
MiniToast.instance.setConfig(
  MiniToastConfig(
    verticalPosition: ToastVerticalPosition.bottom,
    horizontalPosition: ToastHorizontalPosition.center,
    displayDuration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 300),
    toastSpacing: 8.0,
    textStyle: const TextStyle(fontSize: 16),
    iconColor: Colors.white,
    // ... other customization options
  ),
);
```

## 🎯 Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:mini_toast/mini_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastOverlayWrapper(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('MiniToast Demo')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => MiniToast.instance.show(
                    message: 'Success!',
                    variant: ToastVariant.success,
                  ),
                  child: const Text('Show Success Toast'),
                ),
                ElevatedButton(
                  onPressed: () => MiniToast.instance.show(
                    message: 'Error occurred!',
                    variant: ToastVariant.error,
                  ),
                  child: const Text('Show Error Toast'),
                ),
                ElevatedButton(
                  onPressed: () => MiniToast.instance.show(
                    message: 'Waring User!',
                    variant: ToastVariant.warning,
                  ),
                  child: const Text('Show Warning Toast'),
                ),
                ElevatedButton(
                  onPressed: () => MiniToast.instance.show(
                    message: 'Just FYI!',
                    variant: ToastVariant.info,
                  ),
                  child: const Text('Show Info Toast'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## 🔧 Configuration Options

The `MiniToastConfig` class provides these customization options:

- `textStyle`: Custom text style for toast messages
- `verticalPosition`: Top or bottom placement
- `horizontalPosition`: Left, center, or right alignment
- `slideDirection`: Animation slide direction
- `displayDuration`: How long toasts remain visible
- `animationDuration`: Length of show/hide animations
- `toastSpacing`: Space between stacked toasts
- `margin`: Edge margins for toast positioning
- `boxShadow`: Customizable shadow effect
- `borderRadius`: Corner rounding
- `contentPadding`: Inner padding
- `iconColor`: Color for variant icons

## 🧾 License  

This project is licensed under the [Apache License](https://github.com/zohaibanwer984/mini_toast/blob/main/LICENSE).

---

## 🤝 Contributing  

Found a bug or have an idea for a new feature? Feel free to [open an issue](https://github.com/zohaibanwer984/mini_toast/issues) or submit a pull request.  
