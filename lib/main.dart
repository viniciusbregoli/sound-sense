import 'package:flutter/material.dart';
import 'package:sada/devices.dart';
import 'package:sada/home_status_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Minha casa',
                        style: TextStyle(
                            color: Color.fromARGB(255, 12, 0, 0),
                            fontSize: 24.0)),
                    HomeStatusCard()
                  ],
                ),
              ),
            ),
            const Devices()
          ],
        ),
      ),
    );
  }
}
