import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:vibe_project/routes/appRoutes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Seu Perfil'),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(IconlyBold.setting),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null)
              Column(
                children: [
                  Text(
                    'Bem-vindo, ${user.email}!',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Get.snackbar(
                        'Aguarde',
                        'Saindo...',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      await Future.delayed(Duration(seconds: 1));
                      await FirebaseAuth.instance.signOut();
                      Get.toNamed(AppRoutes.signInPage);
                    },
                    child: Text('Sair'),
                  ),
                ],
              )
            else
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
