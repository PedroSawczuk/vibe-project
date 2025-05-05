import 'package:flutter/material.dart';
import 'package:vibe_project/controllers/profile/profileController.dart';
import 'package:vibe_project/theme/customTheme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileController _controller = EditProfileController();
  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    String username = await _controller.fetchUsername();
    setState(() {
      _username = username;
    });
  }

  void _editUsername() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _usernameController =
            TextEditingController(text: _username);

        return AlertDialog(
          title: Text('Editar Username'),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: "Digite seu username"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                String newUsername = _usernameController.text.trim();
                if (newUsername.isNotEmpty) {
                  await _controller.updateUsername(newUsername);
                  setState(() {
                    _username = newUsername;
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seu username:',
              style: TextStyle(
                  color: CustomTheme.lightTheme.colorScheme.outlineVariant),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _username,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _editUsername,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
