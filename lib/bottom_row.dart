import 'package:flutter/material.dart';

class BottomRow extends StatelessWidget {
  const BottomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.home, color: Colors.orange, size: 30.0),
        Icon(Icons.add, color: Colors.orange, size: 30.0),
        Icon(Icons.delete, color: Colors.orange, size: 30.0),
        Icon(Icons.info, color: Colors.orange, size: 30.0),
      ],
    ));
  }
}

