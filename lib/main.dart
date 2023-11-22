import 'package:flutter/material.dart';
import 'package:sada/devices.dart';
import 'package:sada/home_status_card.dart';
import 'bottom_row.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configuração do FlutterLocalNotificationsPlugin
  var initializationSettingsAndroid = const AndroidInitializationSettings(
      '@mipmap/ic_launcher'); // Use o ícone do seu app
  var initializationSettingsIOS = const IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
