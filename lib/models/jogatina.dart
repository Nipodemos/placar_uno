import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'jogatina.g.dart';

@HiveType(typeId: 2)
class Jogatina {
  @HiveField(0)
  int quantidadeDePartidas = 0;

  @HiveField(1)
  DateTime dataInicio = DateTime.now();

  @HiveField(2)
  DateTime dataFim = DateTime.now();

  @HiveField(3)
  List<Map<String, int>> partidas = [];

  @HiveField(4)
  Map<String, int> pontuacaoTotalDosJogadores = {};

  @HiveField(5)
  List<String> jogadores = [];

  @HiveField(6)
  int quantidadeDejogadores;

  @HiveField(7)
  bool completado = false;

  Jogatina({@required this.jogadores, int index})
      : assert(jogadores.length > 0) {
    if (index != null) {
    } else {
      partidas ??= [];
      quantidadeDePartidas = partidas.length;
      quantidadeDejogadores = jogadores.length;
      jogadores.forEach((element) {
        pontuacaoTotalDosJogadores[element] = 0;
      });
    }
  }

  Future salvar({int index}) async {
    Box boxJogatina = Hive.box('jogatinas');
    if (index == null) {
      print(this);
      index = await boxJogatina.add(this);
    } else {
      await boxJogatina.putAt(index, this);
    }
    return index;
  }

  void printJogatinaData(index) {
    Box boxJogatina = Hive.box('jogatina');

    print(boxJogatina.getAt(index));
  }
}
