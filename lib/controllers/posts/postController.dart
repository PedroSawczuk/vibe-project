import 'package:flutter/material.dart';
import 'package:vibe_project/services/post/postServices.dart';

class PostController {
  final PostServices _postServices = PostServices();

  Future<void> createPost(BuildContext context, String content) async {
    await _postServices.addNewPost(context: context, content: content);
  }
  void showAddPostDialog(BuildContext context) {
    final TextEditingController _postContentController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Novo Post'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _postContentController,
              decoration: InputDecoration(
                labelText: 'Conteúdo do Post',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira algum conteúdo.';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String postContent = _postContentController.text;
                  createPost(context, postContent);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Fazer Post'),
            ),
          ],
        );
      },
    );
  }
}
