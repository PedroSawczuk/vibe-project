import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:vibe_project/controllers/posts/postController.dart';
import 'package:vibe_project/models/postModel.dart';
import 'package:vibe_project/services/post/postServices.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PostServices _postServices = PostServices();

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text('Vibe'),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(IconlyBold.chat),
              onPressed: () {
                Get.snackbar('EM BREVE...', 'Jajá vamos implementar essa função...');
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Post>>(
        stream: _postServices.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final posts = snapshot.data;

          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: posts?.length ?? 0,
            itemBuilder: (context, index) {
              final post = posts![index];
              return ListTile(
                title: Text(post.content),
                subtitle: Text('${post.userId} • ${post.createdAt.toLocal()}'),
                onTap: () {},
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context),
        child: Icon(IconlyBold.plus),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final TextEditingController _postContentController =
        TextEditingController();
    final PostController _postController = PostController();
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
                  _postController.createPost(context, postContent);
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
