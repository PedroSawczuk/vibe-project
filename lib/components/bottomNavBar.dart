import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:vibe_project/controller/bottomNavController.dart';

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
        showSelectedLabels: false,  // Desativa labels do item selecionado
        showUnselectedLabels: false, // Desativa labels dos itens não selecionados
        items: [
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.home),
            label: '', // Remova o label aqui
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.search),
            label: '', // Remova o label aqui
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.plus),
            label: '', // Remova o label aqui
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.profile),
            label: '', // Remova o label aqui
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.setting),
            label: '', // Remova o label aqui
          ),
        ],
      ),
    );
  }
}
