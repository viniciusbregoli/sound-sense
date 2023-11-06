import 'package:flutter/material.dart';

class HomeStatusCard extends StatelessWidget {
  const HomeStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade700,
            Colors.orange.shade500,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _DataItem('22°C', 'Temperatura interna'),
              _DataItem('60%', 'Umidade'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _DataItem('30°C', 'Temperatura externa'),
              _DataItem('3', 'Dispositivos Conectados'),
            ],
          ),
        ],
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  final String value;
  final String label;

  const _DataItem(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
