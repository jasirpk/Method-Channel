import 'package:flutter/material.dart';
import 'package:method_channel/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'My App', home: const BatteryWidget());
  }
}

class BatteryWidget extends StatefulWidget {
  const BatteryWidget({super.key});

  @override
  State<BatteryWidget> createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  String batteryLevel = 'Battery Level: unknown';
  final battery = BatteryLevel();

  Future<void> getBatteryLevel() async {
    final level = await battery.getBatteryLevel();

    setState(() {
      batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Widget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             IconButton(onPressed: getBatteryLevel, icon: Icon(Icons.battery_full, size: 100)),
             SizedBox(height: 20),
            Text('$batteryLevel'),
          ],
        ),
      ),
    );
  }
}
