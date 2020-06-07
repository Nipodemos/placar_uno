import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';

class JogatinaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<JogatinaController>(JogatinaController(), permanent: true);
  }
}
