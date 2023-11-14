import 'package:flutter/material.dart';

class Devices extends StatelessWidget {
  const Devices({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.grey[900], // Cor de fundo da seção de dispositivos
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Dispositivos',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  deviceButton('Campainha'),
                  const SizedBox(height: 10.0),
                  deviceButton('Sensor de temperatura'),
                  const SizedBox(height: 10.0),
                  deviceButton('Sensor de umidade'),
                ],
              ),
            ),
            ],
        ),
      ),
    );
  }

  Widget deviceButton(String device) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.orange, // Cor do botão
        borderRadius: BorderRadius.circular(10.0), // Arredondamento do botão
      ),
      child: Text(
        device,
        style: const TextStyle(
          color: Colors.black, // Cor do texto
          fontSize: 16.0, // Tamanho do texto
          fontWeight: FontWeight.bold, // Peso da fonte
        ),
      ),
    );
  }
}
