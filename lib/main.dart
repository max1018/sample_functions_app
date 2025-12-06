import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const SampleFunctionsApp());
}

class SampleFunctionsApp extends StatelessWidget {
  const SampleFunctionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Functions',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random _random = Random();
  final TextEditingController _celsiusController =
      TextEditingController(text: '20');
  final TextEditingController _textController = TextEditingController();

  int _counter = 0;
  int _rolledNumber = 7;
  double? _fahrenheit;
  String _reversed = '';

  @override
  void initState() {
    super.initState();
    _fahrenheit = _convertCelsius(_celsiusController.text);
  }

  @override
  void dispose() {
    _celsiusController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _handleConvert() {
    setState(() {
      _fahrenheit = _convertCelsius(_celsiusController.text);
    });
  }

  double? _convertCelsius(String input) {
    final double? celsius = double.tryParse(input);
    if (celsius == null) {
      return null;
    }
    return (celsius * 9 / 5) + 32;
  }

  void _reverseText() {
    setState(() {
      final String value = _textController.text;
      _reversed = value.split('').reversed.join();
    });
  }

  void _rollNumber() {
    setState(() {
      _rolledNumber = _random.nextInt(100) + 1;
    });
  }

  void _resetAll() {
    setState(() {
      _counter = 0;
      _rolledNumber = 7;
      _celsiusController.text = '20';
      _fahrenheit = _convertCelsius(_celsiusController.text);
      _textController.clear();
      _reversed = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Functions'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetAll,
        tooltip: 'Reset everything',
        child: const Icon(Icons.refresh),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Try a few quick functions',
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _FunctionCard(
            title: 'Counter',
            subtitle: 'Increment and decrement a shared count.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Count: $_counter',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton.tonal(
                      onPressed: _decrementCounter,
                      child: const Text('–1'),
                    ),
                    FilledButton(
                      onPressed: _incrementCounter,
                      child: const Text('+1'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _FunctionCard(
            title: 'Celsius → Fahrenheit',
            subtitle: 'Type a number in °C and convert it.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _celsiusController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Celsius',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _handleConvert(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FilledButton(
                      onPressed: _handleConvert,
                      child: const Text('Convert'),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _fahrenheit != null
                          ? '${_fahrenheit!.toStringAsFixed(1)} °F'
                          : 'Enter a number',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          _FunctionCard(
            title: 'Reverse Text',
            subtitle: 'Flip any text you type.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Enter text',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _reverseText(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FilledButton(
                      onPressed: _reverseText,
                      child: const Text('Reverse'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _reversed.isEmpty ? 'Result appears here' : _reversed,
                        style: textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _FunctionCard(
            title: 'Random Number',
            subtitle: 'Roll between 1 and 100.',
            child: Row(
              children: [
                FilledButton.icon(
                  onPressed: _rollNumber,
                  icon: const Icon(Icons.casino),
                  label: const Text('Roll'),
                ),
                const SizedBox(width: 12),
                Text(
                  _rolledNumber.toString(),
                  style: textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FunctionCard extends StatelessWidget {
  const _FunctionCard({
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
