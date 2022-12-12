import 'package:comic_toon_flutter/views/home.dart';
import 'package:comic_toon_flutter/views/main_screen.dart';
import 'package:comic_toon_flutter/views/screen.dart';
import 'package:comic_toon_flutter/views/screens/auth/forgot_password.dart';
import 'package:comic_toon_flutter/views/screens/auth/login.dart';
import 'package:comic_toon_flutter/views/screens/auth/register.dart';
import 'package:comic_toon_flutter/views/screens/comic_screen.dart';
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
        name: Routes.profileScreen,
        page: () => ProfileScreen(),
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
        bindings:[ AuthBinding(), ]),
    GetPage(
      name: Routes.comicScreen,
      page: () => HomeScreen(),
    ),
    // GetPage(
    //   name: Routes.addProductForm,
    //   page: () => AddProductFromScreen(),
    // ),
    //
    // GetPage(
    //   name: Routes.customerHome,
    //   page: () => CustomerHome(),
    // ),
    // GetPage(
    //   name: Routes.productsFavourites,
    //   page: () => ProductsFavourites(),
    //   binding: BookBinding(),
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
  static const addProductForm = '/AddProductFromScreen';
  static const editProduct = '/EditProductScreen';
  static const customerHome = '/CustomerHome';
  static const productsFavourites = '/productsFavourites';
  static const cartScreen= "/cartScreen";

}