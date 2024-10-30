import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:vibe_project/controllers/bottomNavController.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.find<BottomNavController>();

    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) {
          controller.changePage(index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.notification),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.profile),
            label: '',
          ),
        ],
      ),
    );
  }
}
