import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/jogatina_model.dart';

class JogatinaController extends GetController {
  static JogatinaController get to => Get.find();
  Box boxJogatina = Hive.box('jogatinas');

  int getIndexJogatinaAtual() {
    Box boxJogatinaAtual = Hive.box('jogatinaAtual');
    int indexJogatinaAtual = boxJogatinaAtual.get('indice') as num;
    return indexJogatinaAtual;
  }

  Map<String, bool> quaisEstaoSelecionados = {};

  void updateSelecionados(String jogador, bool estaSelecionado) {
    quaisEstaoSelecionados[jogador] = estaSelecionado;
    update(this);
  }

  void criarNovaJogatina() {
    List<String> jogadoresSelecionados = [];
    quaisEstaoSelecionados.forEach((key, value) {
      if (value == true) jogadoresSelecionados.add(key);
    });
    JogatinaModel jogatina = JogatinaModel(jogadores: jogadoresSelecionados);
    Box boxJogatinaAtual = Hive.box('jogatinaAtual');

    salvarJogatina(jogatinaModel: jogatina).then((value) {
      boxJogatinaAtual.put('indice', value);
      Get.toNamed('jogatina_em_andamento');
    });
  }

  ValueListenable getListenableOfBox(String boxName) {
    Box box = Hive.box(boxName);
    return box.listenable();
  }

  Box getBox(String boxName) {
    return Hive.box(boxName);
  }

  Future<int> addToBox({@required String boxName, @required dynamic value}) {
    Box box = Hive.box(boxName);
    return box.add(value);
  }

  Future<void> addToBoxAt({
    @required String boxName,
    @required int index,
    @required dynamic value,
  }) {
    Box box = Hive.box(boxName);
    return box.putAt(index, value);
  }

  Future salvarJogatina({
    @required JogatinaModel jogatinaModel,
    int index,
  }) async {
    if (index == null) {
      index = await addToBox(boxName: 'jogatinas', value: jogatinaModel);
    } else {
      await addToBoxAt(
        boxName: 'jogatinas',
        index: index,
        value: jogatinaModel,
      );
    }
    return index;
  }

  void printJogatinaData(index) {
    Box boxJogatina = Hive.box('jogatina');

    print(boxJogatina.getAt(index));
  }
}
