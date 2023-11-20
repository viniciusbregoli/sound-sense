import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BluetoothDevicesScreen extends StatelessWidget {
  BluetoothDevicesScreen({super.key});

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devices = [];

  void connectToDevice(BuildContext context, BluetoothDevice device) async {
    await device.connect();
    discoverServices(device);
  }

  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      // Aqui você verifica o UUID do serviço
      if (service.uuid.toString() == "12345678-1234-5678-1234-56789abcdef0") {
        for (var characteristic in service.characteristics) {
          // Verifica o UUID da característica
          if (characteristic.uuid.toString() ==
              "abcdef12-3456-7890-abcd-ef1234567890") {
            characteristic
                .setNotifyValue(true); // Inscreve-se para notificações
            characteristic.value.listen((value) {
              showNotification(value);
            });
          }
        }
      }
    }
  }

  void showNotification(List<int> value) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channelId', // Um ID único para o canal de notificação
      'channelName', // Nome do canal
      channelDescription: 'channelDescription', // Descrição do canal
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails generalNotificationDetails = NotificationDetails(
      android: androidDetails,
    );

    flutterLocalNotificationsPlugin.show(
      0, // ID único para a notificação
      'Notificação BLE', // Título da notificação
      'Dados recebidos: $value', // Corpo da notificação
      generalNotificationDetails, // Detalhes da notificação
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos Bluetooth'),
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: flutterBlue.scanResults,
        initialData: const [],
        builder: (c, snapshot) => ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data![index].device.name),
              subtitle: Text(snapshot.data![index].device.id.toString()),
              onTap: () {
                connectToDevice(context, snapshot.data![index].device);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () =>
            flutterBlue.startScan(timeout: const Duration(seconds: 4)),
      ),
    );
  }
}
