import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class JogadoresController extends GetController {
  static JogadoresController get to => Get.find();

  TextEditingController textEditingController = TextEditingController();
  Box<String> boxJogadores = Hive.box('jogadores');

  void onSubmited() {
    boxJogadores.add(textEditingController.text);
    textEditingController.text = '';
    Get.back();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
