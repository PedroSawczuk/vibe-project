import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_project/models/postModel.dart';
import 'package:vibe_project/routes/appRoutes.dart';

class PostServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> canUserPost(String userId) async {
    final username = await getUsernameById(userId);
    return username != 'Sem username';
  }

  Future<void> addNewPost({
    required BuildContext context,
    required String content,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        if (await canUserPost(user.uid)) {
          CollectionReference postCollection = _firestore.collection('posts');
          await postCollection.add({
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
          Get.toNamed(AppRoutes.editprofilePage);
          Get.snackbar(
            'Ops...',
            'Você precisa adicionar um username antes de postar algo',
            snackPosition: SnackPosition.TOP,
          );
        }
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
        'Erro: ${e.toString()}',
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
                createdAt: (doc['created_at'] as Timestamp).toDate(),
              );
            }).toList());
  }

  Stream<List<Post>> getUserPosts(String userId) {
    return _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Post(
                id: doc.id,
                userId: doc['userId'],
                content: doc['content'],
                createdAt: (doc['created_at'] as Timestamp).toDate(),
              );
            }).toList());
  }

  Future<String> getUsernameById(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      return userDoc['username'] ?? 'Sem username';
    } catch (e) {
      print('Erro ao buscar username: $e');
      return 'Sem username';
    }
  }
}
