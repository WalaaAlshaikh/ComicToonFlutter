import 'package:comic_toon_flutter/views/screens/comic/favourite.dart';
import 'package:comic_toon_flutter/views/screens/comic/home.dart';
import 'package:comic_toon_flutter/views/screens/setting/profile.dart';
import 'package:get/get.dart';

import '../../views/screens/comic/video_screen.dart';

class MainController extends GetxController {
  static var currentIndex = 0.obs;
  @override
  void onInit() {
    currentIndex.value = 0;
    super.onInit();
  }

// for tapping in bottom navigation bar , we need to put them also in routes binding

  // we need to create binding file for main screen to link the pages together
  final taps = [
    HomeScreen(),
    VideoScreen(),
    FavScreen(),
    ProfileScreen(),
  ].obs;

  //here we need to change the title in the app bar based on the taps in the bottom nav

  final title = [
    "Comic Books",
    "Videos",
    "Marked Comic",
    "Profile",
  ].obs;
}
