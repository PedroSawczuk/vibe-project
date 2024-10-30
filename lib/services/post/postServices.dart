import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_project/models/postModel.dart';

class PostServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> addNewPost({
    required BuildContext context,
    required String content,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        CollectionReference post = _firestore.collection('posts');
        await post.add({
          'content': content,
          'userId': user.uid,
          'created_at': Timestamp.now(),
        });
        Get.snackbar(
          'Aguarde',
          'Postando...',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Erro!',
          'Você precisa estar autenticado para fazer o post!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erro inesperado!',
        'Erro: ${e}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Stream<List<Post>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Post(
                id: doc.id,
                userId: doc['userId'],
                content: doc['content'],
                createdAt: (doc['created_at'] as Timestamp) .toDate(),
              );
            }).toList());
  }
}
