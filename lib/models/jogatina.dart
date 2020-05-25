import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'jogatina.g.dart';

@HiveType(typeId: 2)
class Jogatina {
  @HiveField(0)
  int quantidadeDePartidas;

  @HiveField(1)
  DateTime dataInicio;

  @HiveField(2)
  DateTime dataFim;

  @HiveField(3)
  List<Map<String, int>> partidas;

  @HiveField(4)
  Map<String, int> pontuacaoTotalDosJogadores;

  @HiveField(5)
  List<String> players;

  @HiveField(6)
  int quantidadeDePlayers;

  @HiveField(7)
  bool completado = false;

  Jogatina({@required this.players}) : assert(players.length > 0) {
    partidas ??= [];
    quantidadeDePartidas = partidas.length;
    quantidadeDePlayers = players.length;
  }

  Future salvar({int index}) async {
    Box boxJogatina = Hive.box('jogatinas');
    if (index != null) {
      return await boxJogatina.add(this);
    } else {
      return await boxJogatina.putAt(index, this);
    }
  }

  void printJogatinaData(index) {
    Box boxJogatina = Hive.box('jogatina');

    print(boxJogatina.getAt(index));
  }
}
