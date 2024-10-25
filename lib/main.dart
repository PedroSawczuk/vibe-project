import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_project/routes/appRoutes.dart';
import 'package:vibe_project/theme/customTheme.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: CustomTheme.theme, 
      darkTheme: CustomTheme.darkTheme, 
      themeMode: CustomTheme.themeMode, 
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homePage,
      getPages: AppRoutes.routes,
    ),
  );
}
