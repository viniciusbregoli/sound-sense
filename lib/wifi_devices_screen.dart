import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WifiDevicesScreen extends StatelessWidget {
  final WebSocketChannel channel;
  WifiDevicesScreen({super.key, required this.channel});

  final List<String> devices = ['Device 1', 'Device 2', 'Device 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-fi Devices'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index]),
                  onTap: () {
                    // Aqui você se conecta ao WebSocket ao tocar no dispositivo
                    channel.sink.add('Conectar a ${devices[index]}');
                  },
                );
              },
            ),
          ),
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
        ],
      ),
    );
  }
}
