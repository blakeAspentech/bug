import 'package:flutter/material.dart';

void main() => runApp(const iOSFreezeApp());

class iOSFreezeApp extends StatelessWidget {
  const iOSFreezeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: iOSFreeze());
  }
}

class iOSFreeze extends StatefulWidget {
  const iOSFreeze({super.key});

  @override
  State<iOSFreeze> createState() =>
      _iOSFreezeState();
}

class _iOSFreezeState extends State<iOSFreeze> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('iOS Freeze 18.3.1')),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishes execution.
          return Future<void>.delayed(const Duration(hours: 1));
        },
        // Pull from top to show refresh indicator.
        child: ListView()
        
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show refresh indicator programmatically on button tap.
          _refreshIndicatorKey.currentState?.show();
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Show Indicator'),
      ),
    );
  }
}
