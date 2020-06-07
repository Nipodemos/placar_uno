import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supercharged/supercharged.dart';

import '../models/jogatina_model.dart';

class JogatinaController extends GetController {
  static JogatinaController get to => Get.find();

  JogatinaModel _jogatinaModel;
  JogatinaModel get jogatinaModel => _jogatinaModel;

  Box boxJogatinas = Hive.box('jogatinas');
  Box boxJogatinaAtual = Hive.box('jogatinaAtual');

  Map<String, int> pontuacaoTotalDosJogadores = {};
  Map<String, bool> selecionados = {};

  int indexJogatinaAtual;

  @override
  void onInit() {
    indexJogatinaAtual = boxJogatinaAtual.get('indice') ?? null;
    _jogatinaModel = getJogatina();
    super.onInit();
  }

  void alterarSelecionados(bool isSelected, String jogador) {
    selecionados[jogador] = isSelected;
    update();
  }

  void calcularPontuacaoTotalDosJogadores() {
    pontuacaoTotalDosJogadores = {};
    _jogatinaModel.jogadores.forEach((nomeJogador) {
      pontuacaoTotalDosJogadores[nomeJogador] ??= 0;
    });
    _jogatinaModel.resultadoPartidas.forEach((Map<String, int> partida) {
      partida.forEach((nomeJogador, posicaoNaPartida) {
        pontuacaoTotalDosJogadores[nomeJogador] +=
            (_jogatinaModel.jogadores.length - posicaoNaPartida + 1);
      });
    });
  }

  /// Pega a quantidade de vezes que o jogador venceu em cada posição
  ///
  /// Primeio preciso dar um loop sobre cada partida
  /// em cada partida eu pego a posição que ele venceu
  /// e vou adicionando a um contador
  /// no final fica algo tipo assim
  /// a esquer a posição, a direita a quantidade de vezes
  /// que o jogador venceu na posição
  /// ```json
  /// {
  ///   1: 3
  ///   2: 5
  ///   3: 0
  ///   4: 2
  /// }
  /// ```
  ///
  /// depois é tudo convertido para uma string
  String pegarAsVitorias({String jogador}) {
    Map<int, int> quaisPosicoes = {};
    String finalString = '';

    _jogatinaModel.resultadoPartidas.forEach((partida) {
      int posicaoNaPartidaAtual = partida[jogador];
      quaisPosicoes[posicaoNaPartidaAtual]++;
    });
    for (var i = 1; i <= _jogatinaModel.jogadores.length; i++) {
      quaisPosicoes[i] ??= 0;
      finalString += 'Venceu ${quaisPosicoes[i]} vezes em $i\º lugar\n';
    }

    // removendo o último \n da string, já que criaria uma linha em branco
    // desnecessária
    return finalString.allBefore(RegExp("\\n\$"));
  }

  void completarJogatina() {
    _jogatinaModel.dataFim = DateTime.now();

    _jogatinaModel.completado = true;
    JogatinaController.to.updateJogatinaAtual();
    boxJogatinaAtual.delete('indice');
  }

  void create() {
    if (selecionados.isEmpty) {
      throw "JogatinaController.create() error: map 'selecionados' não pode estar vazio";
    }
    List<String> jogadoresSelecionados = [];
    selecionados.forEach((key, value) {
      if (value == true) jogadoresSelecionados.add(key);
    });
    _jogatinaModel = JogatinaModel(jogadores: jogadoresSelecionados);
    print(_jogatinaModel.toString());
    boxJogatinas.add(_jogatinaModel).then((value) {
      boxJogatinaAtual.put('indice', value);
      indexJogatinaAtual = value;
      Get.offNamed('jogatina_em_andamento');
    });
  }

  JogatinaModel getJogatina() {
    if (indexJogatinaAtual == null) {
      return null;
    } else {
      _jogatinaModel = boxJogatinas.getAt(indexJogatinaAtual);
      return _jogatinaModel;
    }
  }

  void updateAt({@required int index}) {
    _jogatinaModel ??= getJogatina();
    boxJogatinas.putAt(index, _jogatinaModel ?? getJogatina());
  }

  void updateJogatinaAtual() {
    int indexJogatinaAtual = boxJogatinaAtual.get('indice');
    boxJogatinas.putAt(indexJogatinaAtual, _jogatinaModel ?? getJogatina());
  }

  void deleteAt({@required int index}) {
    boxJogatinas.deleteAt(index);
  }

  ValueListenable getListenable() {
    Box box = Hive.box('jogatinas');
    return box.listenable();
  }
}
