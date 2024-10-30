import 'package:flutter/material.dart';
import 'package:vibe_project/services/post/postServices.dart';

class PostController {
  final PostServices _postServices = PostServices();

  Future<void> createPost(BuildContext context, String content) async {
    try {
      await _postServices.addNewPost(context: context, content: content);

    } catch (e) {
      throw e;
    }
  }
}
