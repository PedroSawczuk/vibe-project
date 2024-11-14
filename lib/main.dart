import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_project/firebase_options.dart';
import 'package:vibe_project/routes/appRoutes.dart';
import 'package:vibe_project/theme/customTheme.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      theme: CustomTheme.lightTheme, 
      darkTheme: CustomTheme.darkTheme, 
      themeMode: CustomTheme.themeMode, 
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.mainPage,
      getPages: AppRoutes.routes,
    ),
  );
}
