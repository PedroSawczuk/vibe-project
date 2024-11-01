import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibe_project/models/postModel.dart';

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
              final username = snapshot.data ?? 'Usuário não encontrado';
              return Text('Post de $username');
            },
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(post.content),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getUsernameById(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      return userDoc['username'] ?? 'Sem username';
    } catch (e) {
      print('Erro ao buscar username: $e');
      return 'Sem username';
    }
  }
}
