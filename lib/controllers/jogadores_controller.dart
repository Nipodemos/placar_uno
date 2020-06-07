import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class JogadoresController extends GetController {
  static JogadoresController get to => Get.find();

  TextEditingController textEditingController = TextEditingController();
  Box<String> boxJogadores = Hive.box('jogadores');
  Map<String, bool> selecionados = {};

  void alterarSelecionados(bool isSelected, String jogador) {
    selecionados[jogador] = isSelected;
    update();
  }

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

  ValueListenable getListenable() {
    return boxJogadores.listenable();
  }
}
