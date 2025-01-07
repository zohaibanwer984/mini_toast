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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ToastVerticalPosition _verticalPosition = ToastVerticalPosition.bottom;
  ToastHorizontalPosition _horizontalPosition = ToastHorizontalPosition.center;
  ToastSlideDirection _slideDirection = ToastSlideDirection.bottom;
  final Duration _displayDuration = const Duration(seconds: 3);
  Duration _animationDuration = const Duration(milliseconds: 300);
  double _fontSize = 16.0;

  void _updateToastConfig() {
    QuickToast.instance.setConfig(
      QuickToastConfig(
        textStyle: TextStyle(
          fontSize: _fontSize,
          fontWeight: FontWeight.w500,
        ),
        iconColor: Colors.red,
        horizontalPosition: _horizontalPosition,
        verticalPosition: _verticalPosition,
        slideDirection: _slideDirection,
        displayDuration: _displayDuration,
        animationDuration: _animationDuration,
        contentPadding: EdgeInsets.all(12),
        toastSpacing: 10,
        margin: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(150),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateToastConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickToast Features Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Position Settings',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<ToastVerticalPosition>(
                      value: _verticalPosition,
                      decoration:
                          const InputDecoration(labelText: 'Vertical Position'),
                      items: ToastVerticalPosition.values
                          .map((pos) => DropdownMenuItem(
                              value: pos, child: Text(pos.name)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _verticalPosition = value!;
                          _updateToastConfig();
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<ToastHorizontalPosition>(
                      value: _horizontalPosition,
                      decoration: const InputDecoration(
                          labelText: 'Horizontal Position'),
                      items: ToastHorizontalPosition.values
                          .map((pos) => DropdownMenuItem(
                              value: pos, child: Text(pos.name)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _horizontalPosition = value!;
                          _updateToastConfig();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Animation Settings',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<ToastSlideDirection>(
                      value: _slideDirection,
                      decoration:
                          const InputDecoration(labelText: 'Slide Direction'),
                      items: ToastSlideDirection.values
                          .map((dir) => DropdownMenuItem(
                              value: dir, child: Text(dir.name)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _slideDirection = value!;
                          _updateToastConfig();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Animation Duration'),
                              Slider(
                                value: _animationDuration.inMilliseconds
                                    .toDouble(),
                                min: 100,
                                max: 1000,
                                divisions: 9,
                                label: '${_animationDuration.inMilliseconds}ms',
                                onChanged: (value) {
                                  setState(() {
                                    _animationDuration =
                                        Duration(milliseconds: value.round());
                                    _updateToastConfig();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Style Settings',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Font Size'),
                              Slider(
                                value: _fontSize,
                                min: 12,
                                max: 24,
                                divisions: 12,
                                label: _fontSize.round().toString(),
                                onChanged: (value) {
                                  setState(() {
                                    _fontSize = value;
                                    _updateToastConfig();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => QuickToast.instance.show(
                      message: 'Success message with current settings',
                      variant: ToastVariant.success,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Show Success Toast'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => QuickToast.instance.show(
                      message: 'Error message with current settings',
                      variant: ToastVariant.error,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Show Error Toast'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Show multiple toasts with different configurations
                      QuickToast.instance.show(
                        message: 'First Toast\nWith multiple lines\nof text',
                        variant: ToastVariant.info,
                        displayDuration: const Duration(seconds: 5),
                        iconColor: Colors.deepPurple,
                      );
                      Future.delayed(const Duration(milliseconds: 200), () {
                        QuickToast.instance.show(
                          message: 'Second Toast',
                          variant: ToastVariant.success,
                          displayDuration: const Duration(seconds: 4),
                          iconColor: Colors.lightGreen,
                        );
                      });
                      Future.delayed(const Duration(milliseconds: 400), () {
                        QuickToast.instance.show(
                          message: 'Third Toast',
                          variant: ToastVariant.error,
                          displayDuration: const Duration(seconds: 3),
                          iconColor: Colors.yellow,
                        );
                      });
                    },
                    child: const Text('Show Multiple Toasts'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
