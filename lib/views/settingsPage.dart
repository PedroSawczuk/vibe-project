import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Center(
            child: Text('Settings!'),
          ),
        ],
      ),
    );
  }
}
