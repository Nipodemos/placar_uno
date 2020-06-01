import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'jogatina_model.g.dart';

@HiveType(typeId: 2)
class JogatinaModel {
  @HiveField(1)
  DateTime dataInicio = DateTime.now();

  @HiveField(2)
  DateTime dataFim = DateTime.now();

  @HiveField(3)
  List<Map<String, int>> resultadoPartidas = [];

  @HiveField(5)
  List<String> jogadores = [];

  @HiveField(7)
  bool completado = false;

  JogatinaModel({@required this.jogadores, int index})
      : assert(jogadores.length > 0) {
    if (index != null) {
    } else {
      resultadoPartidas ??= [];
    }
  }
  
}
