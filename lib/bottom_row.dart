import 'package:flutter/material.dart';
import 'package:sada/bluetooth_devices_screen.dart';
import 'package:sada/wifi_devices_screen.dart';

class BottomRow extends StatelessWidget {
  const BottomRow({super.key});

  @override
  Widget build(BuildContext context) {
    void openAddDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.orange,
            title: const Text('Escolha como deseja encontrar seu dispositivo'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text('Bluetooth',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BluetoothDevicesScreen()),
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text('Wi-fi',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WifiDevicesScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        barrierDismissible:
            true, // Set to false if you want to force a selection
        barrierColor: Colors.black54, // Darkens the background
      );
    }

    void openInfoDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.orange,
            title: const Text('Informações'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Versão: 1.0.0'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Fechar",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Icon(Icons.home, color: Colors.orange, size: 30.0),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.orange, size: 30.0),
          onPressed: openAddDialog,
        ),
        const Icon(Icons.delete, color: Colors.orange, size: 30.0),
        IconButton(
          icon: const Icon(Icons.info, color: Colors.orange, size: 30.0),
          onPressed: openInfoDialog,
        ),
      ],
    );
  }
}
