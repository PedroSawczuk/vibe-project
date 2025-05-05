import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibe_project/models/postModel.dart';
import 'package:vibe_project/utils/dateUtils.dart';
import 'package:iconly/iconly.dart';
import 'package:get/get.dart';

class DetailPostPage extends StatelessWidget {
  const DetailPostPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: FutureBuilder<String>(
            future: getUsernameById(post.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Erro ao carregar username');
              }
              final username = snapshot.data ?? 'User Not Found';
              return Text(
                'Post de $username',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<String>(
        future: getUsernameById(post.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar username'));
          }
          final username = snapshot.data ?? 'User Not Found';

          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post content
                  Text(
                    post.content,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),

                  // Username and post date
                  Text(
                    '$username • ${DateFormatter.formatDate(post.createdAt)}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Social actions (like, comment, share)
                  Row(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> getUsernameById(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return userDoc['username'] ?? 'Sem username';
    } catch (e) {
      print('Erro ao buscar username: $e');
      return 'Sem username';
    }
  }
}
