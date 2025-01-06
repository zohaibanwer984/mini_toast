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
        title: 'QuickToast Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
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
      appBar: AppBar(
        title: const Text('QuickToast Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ToastButton(
              label: 'Show Success Toast',
              onPressed: () {
                QuickToast.instance.show(
                  message: 'Operation completed successfully!',
                  variant: ToastVariant.success,
                  duration: const Duration(seconds: 2),
                );
              },
            ),
            const SizedBox(height: 16),
            _ToastButton(
              label: 'Show Error Toast',
              onPressed: () {
                QuickToast.instance.show(
                  message: 'Something went wrong!',
                  variant: ToastVariant.error,
                  duration: const Duration(seconds: 3),
                );
              },
            ),
            const SizedBox(height: 16),
            _ToastButton(
              label: 'Show Info Toast',
              onPressed: () {
                QuickToast.instance.show(
                  message: 'Here is some information',
                  variant: ToastVariant.info,
                  duration: const Duration(seconds: 2),
                );
              },
            ),
            const SizedBox(height: 16),
            _ToastButton(
              label: 'Show Multiple Toasts',
              onPressed: () {
                QuickToast.instance.show(
                  message: 'First Toast',
                  variant: ToastVariant.info,
                  duration: const Duration(seconds: 7),
                );
                QuickToast.instance.show(
                  message: 'Second Toast',
                  variant: ToastVariant.success,
                  duration: const Duration(seconds: 3),
                );
                QuickToast.instance.show(
                  message: 'Third Toast',
                  variant: ToastVariant.error,
                  duration: const Duration(seconds: 5),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ToastButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ToastButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Text(label),
    );
  }
}
