import 'package:flutter/material.dart';
import 'package:sada/bottom_row.dart';

class Devices extends StatelessWidget {
  const Devices({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dispositivos',
                style: TextStyle(color: Colors.white, fontSize: 24.0)),
            const SizedBox(height: 20.0),
            deviceButton('Campainha'),
            deviceButton('Sensor de temperatura'),
            deviceButton('Sensor de umidade'),
            const Spacer(),
            const BottomRow(),
          ],
        ),
      ),
    );
  }

  Widget deviceButton(String device) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(device, style: const TextStyle(color: Colors.white)),
    );
  }
}

class StyledText extends StatelessWidget {
  const StyledText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World',
        style: TextStyle(fontSize: 28, color: Colors.white));
  }
}
