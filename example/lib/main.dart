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
        title: 'MiniToast Demo',
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
  // Configurable toast settings
  ToastVerticalPosition _verticalPosition = ToastVerticalPosition.bottom;
  ToastHorizontalPosition _horizontalPosition = ToastHorizontalPosition.center;
  ToastSlideDirection _slideDirection = ToastSlideDirection.bottom;
  final Duration _displayDuration = const Duration(seconds: 3);
  Duration _animationDuration = const Duration(milliseconds: 300);
  double _fontSize = 16.0;

  @override
  void initState() {
    super.initState();
    _updateToastConfig();
  }

  void _updateToastConfig() {
    MiniToast.instance.setConfig(
      MiniToastConfig(
        textStyle: TextStyle(
          fontSize: _fontSize,
          fontWeight: FontWeight.w500,
        ),
        // iconColor: Colors.deepPurpleAccent,
        horizontalPosition: _horizontalPosition,
        verticalPosition: _verticalPosition,
        slideDirection: _slideDirection,
        displayDuration: _displayDuration,
        animationDuration: _animationDuration,
        contentPadding: const EdgeInsets.all(12),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniToast Features Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCard(
              title: 'Position Settings',
              children: [
                _buildDropdown<ToastVerticalPosition>(
                  label: 'Vertical Position',
                  value: _verticalPosition,
                  items: ToastVerticalPosition.values,
                  onChanged: (value) {
                    setState(() {
                      _verticalPosition = value!;
                      _updateToastConfig();
                    });
                  },
                ),
                _buildDropdown<ToastHorizontalPosition>(
                  label: 'Horizontal Position',
                  value: _horizontalPosition,
                  items: ToastHorizontalPosition.values,
                  onChanged: (value) {
                    setState(() {
                      _horizontalPosition = value!;
                      _updateToastConfig();
                    });
                  },
                ),
              ],
            ),
            _buildCard(
              title: 'Animation Settings',
              children: [
                _buildDropdown<ToastSlideDirection>(
                  label: 'Slide Direction',
                  value: _slideDirection,
                  items: ToastSlideDirection.values,
                  onChanged: (value) {
                    setState(() {
                      _slideDirection = value!;
                      _updateToastConfig();
                    });
                  },
                ),
                _buildSlider(
                  label: 'Animation Duration',
                  value: _animationDuration.inMilliseconds.toDouble(),
                  min: 100,
                  max: 1000,
                  divisions: 9,
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
            _buildCard(
              title: 'Style Settings',
              children: [
                _buildSlider(
                  label: 'Font Size',
                  value: _fontSize,
                  min: 12,
                  max: 24,
                  divisions: 12,
                  onChanged: (value) {
                    setState(() {
                      _fontSize = value;
                      _updateToastConfig();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildButton(
              label: 'Show Success Toast',
              color: Colors.green,
              onPressed: () => MiniToast.instance.show(
                message: 'Success message with current settings',
                variant: ToastVariant.success,
              ),
            ),
            _buildButton(
              label: 'Show Error Toast',
              color: Colors.red,
              onPressed: () => MiniToast.instance.show(
                message: 'Error message with current settings',
                variant: ToastVariant.error,
              ),
            ),
            _buildButton(
              label: 'Show Waring Toast',
              color: Colors.orange,
              onPressed: () => MiniToast.instance.show(
                message: 'Warning message with current settings',
                variant: ToastVariant.warning,
              ),
            ),
            _buildButton(
              label: 'Show Multiple Toasts',
              onPressed: () {
                MiniToast.instance.show(
                  message: 'First Toast\nWith multiple lines\nof text',
                  variant: ToastVariant.info,
                  displayDuration: const Duration(seconds: 5),
                  iconColor: Colors.deepPurple,
                );
                Future.delayed(const Duration(milliseconds: 200), () {
                  MiniToast.instance.show(
                    message: 'Second Toast',
                    variant: ToastVariant.success,
                    displayDuration: const Duration(seconds: 4),
                    iconColor: Colors.lightGreen,
                  );
                });
                Future.delayed(const Duration(milliseconds: 400), () {
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
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: items
          .map((item) =>
              DropdownMenuItem(value: item, child: Text(item.toString())))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: value.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    Color color = Colors.blue,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        child: Text(label),
      ),
    );
  }
}
