// lib/views/homePage.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:vibe_project/controllers/posts/postController.dart';
import 'package:vibe_project/models/postModel.dart';
import 'package:vibe_project/services/post/postServices.dart';
import 'package:vibe_project/utils/dateUtils.dart';  
import 'package:vibe_project/views/post/detailPostPage.dart';

class HomePage extends StatelessWidget {
  final PostController _postController = PostController(); 

  HomePage({super.key});

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
              return FutureBuilder<String>(
                future: _postServices.getUsernameById(post.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text(post.content),
                      subtitle: Text('Carregando username... • ${DateFormatter.formatDate(post.createdAt)}'),
                    );
                  }

                  final username = snapshot.data ?? 'User Not Found';
                  return Column(
                    children: [
                      ListTile(
                        title: Text(post.content),
                        subtitle: Text('$username • ${DateFormatter.formatDate(post.createdAt)}'),
                        onTap: () {
                          Get.to(() => DetailPostPage(post: post));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(IconlyBold.heart),
                              onPressed: () {
                                Get.snackbar('Curtir', 'Em breve...');
                              },
                            ),
                            Text('0'),
                            IconButton(
                              icon: Icon(IconlyBold.chat),
                              onPressed: () {
                                Get.snackbar('Comentar', 'Em breve...');
                              },
                            ),
                            Text('0'),
                            IconButton(
                              icon: Icon(IconlyBold.send),
                              onPressed: () {
                                Get.snackbar('Compartilhar', 'Em breve...');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _postController.showAddPostDialog(context),
        child: Icon(IconlyBold.plus),
      ),
    );
  }
}
