import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:vibe_project/models/postModel.dart';
import 'package:vibe_project/routes/appRoutes.dart';
import 'package:vibe_project/services/post/postServices.dart';
import 'package:vibe_project/utils/dateUtils.dart';
import 'package:vibe_project/views/post/detailPostPage.dart';
import '../../theme/customTheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<String> _getUsername(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      return userDoc['username'] ?? 'Sem nome de usuário';
    } catch (e) {
      print('Erro ao carregar username: $e');
      return 'Sem nome de usuário';
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final PostServices _postServices = PostServices();

    return Scaffold(
      appBar: AppBar(
        title: Text('Seu Perfil'),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(IconlyBold.setting),
              onPressed: () {
                Get.toNamed(AppRoutes.settingsPage);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (user != null) ...[
              // Exibe o nome de usuário e o e-mail
              FutureBuilder<String>(
                future: _getUsername(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Erro ao carregar username');
                  }

                  final username = snapshot.data ?? 'Sem nome de usuário';
                  return Column(
                    children: [
                      Text(username, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('${user.email}', style: TextStyle(fontSize: 18)),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.editprofilePage);
                    },
                    child: Text('Editar Perfil'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomTheme.lightTheme.colorScheme.error,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      Get.snackbar(
                        'Aguarde',
                        'Saindo...',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      await Future.delayed(Duration(seconds: 1));
                      await FirebaseAuth.instance.signOut();
                      Get.offAndToNamed(AppRoutes.signInPage);
                    },
                    child: Text('Sair'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Seus Posts:'),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<List<Post>>(
                  stream: _postServices.getUserPosts(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    }

                    final posts = snapshot.data;

                    return ListView.separated(
                      itemCount: posts?.length ?? 0,
                      itemBuilder: (context, index) {
                        final post = posts![index];
                        return ListTile(
                          title: Text(post.content),
                          subtitle: Text('${DateFormatter.formatDate(post.createdAt)}'),
                          onTap: () {
                            Get.to(() => DetailPostPage(post: post));
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    );
                  },
                ),
              ),
            ] else
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.signInPage);
                },
                child: Text('Entrar'),
              ),
          ],
        ),
      ),
    );
  }
}
