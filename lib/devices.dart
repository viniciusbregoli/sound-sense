import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';

class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  DevicesState createState() => DevicesState();
}

class DevicesState extends State<Devices> {
  IOWebSocketChannel? channel;
  Timer? heartbeatTimer;
  final int heartbeatIntervalSeconds = 5;
  bool heartbeatAckReceived = true;

  List<String> deviceNames = [
    'Campainha',
    'Sensor de temperatura',
    'Sensor de umidade'
  ];

  Color bellButtonColor = Colors.orange; // Cor padrão do botão Campainha

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    channel?.sink.close();
    stopHeartbeat();
    super.dispose();
  }

  void connectToWebSocket() {
    channel = IOWebSocketChannel.connect('ws://172.20.10.8/ws');
    startHeartbeat();
    setState(() {
      bellButtonColor = Colors.green; // Muda a cor para verde ao conectar
    });

    channel?.stream.listen((message) {
      if (message == 'heartbeat_ack') {
        heartbeatAckReceived = true; // Ack do heartbeat recebido
      }
    }, onDone: () {
      // WebSocket foi fechado
      setState(() {
        bellButtonColor =
            Colors.orange; // Muda a cor para laranja quando desconecta
      });
    }, onError: (error) {
      // Erro na conexão WebSocket
      setState(() {
        bellButtonColor =
            Colors.orange; // Muda a cor para laranja em caso de erro
      });
    });
  }

  void startHeartbeat() {
    stopHeartbeat(); // Para o heartbeat anterior se existir
    heartbeatTimer =
        Timer.periodic(Duration(seconds: heartbeatIntervalSeconds), (timer) {
      sendHeartbeat();
      // Inicia um temporizador para verificar a resposta
      Future.delayed(Duration(seconds: heartbeatIntervalSeconds), () {
        if (!heartbeatAckReceived) {
          // Resposta não recebida
          print("Conexão perdida.");
          // Aqui você pode atualizar a UI ou tentar reconectar
          bellButtonColor = Colors.orange;
        }
        heartbeatAckReceived = false; // Reseta a flag para o próximo heartbeat
      });
    });
  }

  void sendHeartbeat() {
    if (channel != null) {
      channel!.sink.add('heartbeat'); // Enviar mensagem de heartbeat
      // Você pode implementar lógica adicional aqui, como verificar se uma resposta foi recebida
      heartbeatAckReceived = false;
    }
  }

  void stopHeartbeat() {
    heartbeatTimer?.cancel();
  }

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
              child: ListView.separated(
                itemCount: deviceNames.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (deviceNames[index] == 'Campainha') {
                        connectToWebSocket();
                      }
                      // Aqui, você pode adicionar lógica adicional para outros dispositivos, se necessário
                    },
                    child: deviceButton(
                        deviceNames[index],
                        deviceNames[index] == 'Campainha'
                            ? bellButtonColor
                            : Colors.orange),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deviceButton(String device, Color color) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color, // Cor do botão baseada no parâmetro
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        device,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
