import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_project/theme/customTheme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Variável para armazenar o tema selecionado
  ThemeMode? _selectedThemeMode;

  @override
  void initState() {
    super.initState();
    _selectedThemeMode = CustomTheme.themeMode;
  }

  void _changeTheme(ThemeMode? value) {
    setState(() {
      _selectedThemeMode = value;
      Get.changeThemeMode(value ?? ThemeMode.system);
    });
  }

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
            child: Text('Configurações de Tema'),
          ),
          // Dropdown para seleção do tema
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<ThemeMode>(
              value: _selectedThemeMode,
              onChanged: _changeTheme,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text("Padrão do Sistema"),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text("Modo Claro"),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text("Modo Escuro"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
