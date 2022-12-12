import 'package:comic_toon_flutter/logic/controllers/comic_controller.dart';
import 'package:get/get.dart';

class ComicBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ComicController());


  }
}