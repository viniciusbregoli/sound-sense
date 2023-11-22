import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  DevicesState createState() => DevicesState();
}

class DevicesState extends State<Devices> {
  IOWebSocketChannel? channel;
  Timer? messageTimer;
  bool alive = true;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
    super.dispose();
  }

  void connectToWebSocket() {
    channel = IOWebSocketChannel.connect('ws://192.168.15.7/ws');

    showNotification('Conectado ao WebSocket', 'Você está conectado com sucesso.');

    setState(() {
      bellButtonColor = Colors.green; // Muda a cor para verde ao conectar
    });

    channel?.stream.listen((message) {
      if (message == 'heartbeat') {
        setState(() {
          alive = true;
        });
      }
      resetMessageTimer();
    }, onDone: () {
      setState(() {
        bellButtonColor = Colors.orange;
      });
    }, onError: (error) {
      setState(() {
        bellButtonColor = Colors.orange;
      });
    });
    startMessageTimer();
  }

  void startMessageTimer() {
    messageTimer = Timer(const Duration(seconds: 5), () {
      // Executa esse código quando o temporizador expirar
      // Verifica se a mensagem não foi recebida nos últimos 5 segundos
      setState(() {
        // Faça o que você precisa fazer aqui, como mudar a cor de volta para a cor padrão
        setState(() {
          bellButtonColor = Colors.orange;
        });
      });
    });
  }

  void resetMessageTimer() {
    // Reseta o temporizador para começar a contar a partir do zero novamente
    messageTimer?.cancel();
    startMessageTimer();
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

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Um ID de canal exclusivo para Android
      'Nome do canal', // Um nome de canal para Android
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Um ID de notificação exclusivo
      title,
      body,
      platformChannelSpecifics,
      payload: 'Notificação exemplo',
    );
  }
}
