import 'package:flutter/material.dart';

class WifiDevicesScreen extends StatelessWidget {
  WifiDevicesScreen({super.key});


  final List<String> devices = ['Device 1', 'Device 2', 'Device 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-fi Devices'),
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
