import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:vibe_project/models/postModel.dart';
import 'package:vibe_project/routes/appRoutes.dart';
import 'package:vibe_project/services/post/postServices.dart';
import '../../theme/customTheme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              Text('${user.email}', style: TextStyle(fontSize: 18)),
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
                      backgroundColor: CustomTheme.theme.colorScheme.error,
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
                          subtitle: Text('${_formatDate(post.createdAt)}'),
                          onTap: () {},
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

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy, HH:mm').format(dateTime.toLocal());
  }
}
