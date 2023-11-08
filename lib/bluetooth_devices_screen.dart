import 'package:flutter/material.dart';

class BluetoothDevicesScreen extends StatelessWidget {
  BluetoothDevicesScreen({super.key});


  final List<String> devices = ['Device 1', 'Device 2', 'Device 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devices[index]),
          );
        },
      ),
    );
  }
}
