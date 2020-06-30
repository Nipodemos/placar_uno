import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogadores_controller.dart';

class JogadoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JogadoresController>(() => JogadoresController());
  }
}
