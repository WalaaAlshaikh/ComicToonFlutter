import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controllers/auth_controllers.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());


  }
}