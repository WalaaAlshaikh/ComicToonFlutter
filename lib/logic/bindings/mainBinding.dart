
import 'package:get/get.dart';


import '../controllers/main_controller.dart';
import '../controllers/setting_controller.dart';

class MainBinding extends Bindings{
  @override
  // each controller has binding
  void dependencies() {
    Get.put(MainController());
    Get.put(SettingController());

  }


}