import 'package:get/get.dart';
import 'package:vibe_project/views/auth/signInPage.dart';
import 'package:vibe_project/views/auth/signUpPage.dart';
import 'package:vibe_project/views/mainPage.dart';
import 'package:vibe_project/views/profile/editProfilePage.dart';
import 'package:vibe_project/views/profile/profilePage.dart';
import 'package:vibe_project/views/searchPage.dart';
import 'package:vibe_project/views/settingsPage.dart';
import '../views/homePage.dart';

class AppRoutes {
  static const String mainPage = '/';
  static const String homePage = '/homePage';
  static const String searchPage = '/searchPage';
  static const String profilePage = '/profilePage';
  static const String editprofilePage = '/editprofilePage';
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
      name: profilePage,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: editprofilePage,
      page: () => EditProfilePage(),
    ),
    GetPage(
      name: settingsPage,
      page: () => SettingsPage(),
    ),

    // ==================================================
    // AUTH
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
