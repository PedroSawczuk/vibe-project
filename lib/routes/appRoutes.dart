import 'package:get/get.dart';
import 'package:vibe_project/views/auth/signInPage.dart';
import 'package:vibe_project/views/auth/signUpPage.dart';
import 'package:vibe_project/views/mainPage.dart';
import 'package:vibe_project/views/posts/addPostPage.dart';
import 'package:vibe_project/views/profilePage.dart';
import 'package:vibe_project/views/searchPage.dart';
import 'package:vibe_project/views/settingsPage.dart';
import '../views/homePage.dart';

class AppRoutes {
  static const String mainPage = '/';
  static const String homePage = '/homePage';
  static const String searchPage = '/searchPage';
  static const String addPostPage = '/addPostPage';
  static const String profilePage = '/profilePage';
  static const String settingsPage = '/settingsPage';

  // Auth
  static const String signInPage = '/signInPage';
  static const String signUpPage = '/signUpPage';

  static final routes = [
    GetPage(
      name: mainPage,
      page: () => MainPage(),
    ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: searchPage,
      page: () => SearchPage(),
    ),
    GetPage(
      name: addPostPage,
      page: () => AddPostPage(),
    ),
    GetPage(
      name: profilePage,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: settingsPage,
      page: () => SettingsPage(),
    ),
    GetPage(
      name: signInPage,
      page: () => SignInPage(),
    ),
    GetPage(
      name: signUpPage,
      page: () => SignUpPage(),
    ),
  ];
}
