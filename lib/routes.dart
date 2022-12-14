import 'package:comic_toon_flutter/logic/bindings/comic_binding.dart';
import 'package:comic_toon_flutter/logic/bindings/mainBinding.dart';
import 'package:comic_toon_flutter/views/screens/comic/comic_detail.dart';
import 'package:comic_toon_flutter/views/screens/comic/favourite.dart';
import 'package:comic_toon_flutter/views/screens/comic/home.dart';
import 'package:comic_toon_flutter/views/main_screen.dart';
import 'package:comic_toon_flutter/views/widgets/comic/carditem.dart';
import 'package:comic_toon_flutter/views/screens/auth/forgot_password.dart';
import 'package:comic_toon_flutter/views/screens/auth/login.dart';
import 'package:comic_toon_flutter/views/screens/auth/register.dart';

import 'package:comic_toon_flutter/views/screens/setting/edit_profile_screen.dart';
import 'package:comic_toon_flutter/views/screens/setting/profile.dart';
import 'package:comic_toon_flutter/views/screens/setting/settings_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'logic/bindings/auth_binding.dart';

class AppRoutes {
  static const login = Routes.loginScreen;
  static const main = Routes.mainScreen;

  static final routes = [
    GetPage(
        name: Routes.loginScreen,
        page: () => LoginScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.signUpScreen,
        page: () => RegisterScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.forgotPasswordScreen,
        page: () => ForgetPass(),
        binding: AuthBinding()),

    GetPage(
        name: Routes.editProfileScreen,
        page: () => EditProfileScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.settingsScreen,
        page: () => SettingScreen(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.mainScreen,
        page: () => MainScreen(),
        bindings:[ AuthBinding(),ComicBinding(),MainBinding()]),
    GetPage(
      name: Routes.comicScreen,
      page: () => HomeScreen(),
      binding: ComicBinding()
    ),

    // GetPage(
    //   name: Routes.comicFavourites,
    //   page: () => FavScreen(),
    //   binding: ComicBinding(),
    // ),

  ];
}

class Routes {
  static const loginScreen = '/loginScreen';
  static const signUpScreen = '/signUpScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const profileScreen = '/profileScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const settingsScreen = '/settingsScreen';
  static const mainScreen = '/mainScreen';
  static const comicScreen = '/ComicScreen';
  static const editProduct = '/EditProductScreen';
  static const comicFavourites = '/comicFavourites';



}