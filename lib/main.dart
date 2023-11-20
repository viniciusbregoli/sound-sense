import 'package:flutter/material.dart';
import 'package:sada/devices.dart';
import 'package:sada/home_status_card.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'bottom_row.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/io.dart';

void main() async {
  final channel = IOWebSocketChannel.connect('ws://192.168.15.3/ws');

  WidgetsFlutterBinding.ensureInitialized();
  // Configuração do FlutterLocalNotificationsPlugin
  var initializationSettingsAndroid = const AndroidInitializationSettings(
      '@mipmap/ic_launcher'); // Use o ícone do seu app
  var initializationSettingsIOS = const IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp(channel: channel));
}

class MyApp extends StatelessWidget {
  final WebSocketChannel channel;

  const MyApp({super.key, required this.channel});

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
                child: BottomRow(channel: channel),
              )
            ],
          ),
        ),
      ),
    );
  }
}
