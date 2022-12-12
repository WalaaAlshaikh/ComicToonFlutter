import 'package:comic_toon_flutter/views/screens/comic/home.dart';
import 'package:comic_toon_flutter/views/screens/setting/profile.dart';
import 'package:comic_toon_flutter/views/screens/setting/settings_screen.dart';
import 'package:get/get.dart';

class MainController  extends GetxController{
  RxInt currentIndex=0.obs;
// for tapping in bottom navigation bar , we need to put them also in routes binding

  // we need to create binding file for main screen to link the pages together
  final taps=[
    HomeScreen(),
    ProfileScreen(),



  ].obs;

  //here we need to change the title in the app bar based on the taps in the bottom nav

  final title=[
    "Comic Books",
    "Book Store",
    "Bookmark",
    "",
  ].obs;


}