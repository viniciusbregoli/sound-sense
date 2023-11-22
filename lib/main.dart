import 'package:flutter/material.dart';
import 'package:sada/devices.dart';
import 'package:sada/home_status_card.dart';
import 'bottom_row.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Crie uma instância de FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Configure as configurações padrão das notificações
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {
      // Este callback é chamado quando o usuário toca na notificação
    },
  );

  runApp(const MyApp());
}

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
