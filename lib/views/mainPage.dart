import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_project/components/bottomNavBar.dart';
import 'package:vibe_project/controller/bottomNavController.dart';
import 'package:vibe_project/views/homePage.dart';
import 'package:vibe_project/views/posts/addPostPage.dart';
import 'package:vibe_project/views/profilePage.dart';
import 'package:vibe_project/views/notificationsPage.dart';
import 'package:vibe_project/views/searchPage.dart';

class MainPage extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    AddPostPage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}