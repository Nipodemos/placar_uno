import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'player.g.dart';

@HiveType(typeId: 1)
class Player extends HiveObject {
  Player({this.nome});

  Box<Player> playersBox = Hive.box('players');

  @override
  String toString() {
    return 'Nome: ' + nome;
  }

  @HiveField(0)
  String nome;

  List<Player> getAllPlayers() {
    List<Player> allPlayers;
    for (var i = 0; i < playersBox.length; i++) {
      allPlayers.add(playersBox.getAt(i));
    }
    return allPlayers;
  }

  ValueListenable<dynamic> getBoxListenable() {
    return playersBox.listenable();
  }
}
