import 'package:flutter/material.dart';
import 'package:sada/devices.dart';
import 'package:sada/home_status_card.dart';
import 'bottom_row.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey[900],
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'Minha casa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
              const HomeStatusCard(),
              const Expanded(child: Devices()),
              Container(
                color: Colors.grey[900],
                padding: const EdgeInsets.all(20.0),
                child: const BottomRow(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
