# QuickToast 🍞  

A lightweight and easy-to-use toast notification library for Flutter. QuickToast makes it simple to display customizable, elegant toast notifications in your Flutter apps with minimal setup.

---

## ✨ Features  
- 🟢 **Success Toasts**: Notify users about successful operations.  
- 🔴 **Error Toasts**: Display error messages gracefully.  
- 🔵 **Info Toasts**: Share informational messages with users.  
- ⏱ **Customizable Duration**: Control how long a toast is visible.  
- 📜 **Queue System**: Manage multiple toasts effortlessly.  
- 🔄 **Simple API**: Built-in `ToastManager` singleton for easy use.  

---

## 📦 Installation  

Add QuickToast to your `pubspec.yaml`:  
```yaml
dependencies:
  quick_toast: ^0.1.0
```

Run `flutter pub get` to fetch the package.

---

## 🚀 Getting Started  

### Wrap Your App  

To enable QuickToast, wrap your app in `ToastOverlayWrapper`:  
```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastOverlayWrapper(
      child: MaterialApp(
        title: 'QuickToast Demo',
        home: const MyHomePage(),
      ),
    );
  }
}
```

---

### Display a Toast  

Use the `ToastManager` singleton to show toasts:  
```dart
ToastManager.instance.show(
  message: 'Operation completed successfully!',
  variant: ToastVariant.success,  // success, error, or info
  duration: const Duration(seconds: 2),
);
```

---

## 🧑‍💻 Example  

Here’s a complete example demonstrating various types of toasts:  
```dart
import 'package:flutter/material.dart';
import 'package:quick_toast/quick_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastOverlayWrapper(
      child: MaterialApp(
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuickToast Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ToastManager.instance.show(
              message: 'Hello from QuickToast!',
              variant: ToastVariant.info,
            );
          },
          child: const Text('Show Toast'),
        ),
      ),
    );
  }
}
```

---

## 🎨 Customization  

QuickToast provides predefined `ToastVariant`s (`success`, `error`, `info`), but you can customize the look and feel of your toasts by extending its functionality (coming soon).  

---

## 🧾 License  

This project is licensed under the [Apache License](https://github.com/zohaibanwer984/quick_toast/blob/main/LICENSE).

---

## 🤝 Contributing  

Found a bug or have an idea for a new feature? Feel free to [open an issue](https://github.com/zohaibanwer984/quick_toast/issues) or submit a pull request.  
