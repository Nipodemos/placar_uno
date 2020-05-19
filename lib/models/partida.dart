import 'Player.dart';
import 'package:hive/hive.dart';

class Partida {
  Box<Partida> detalhesDaPartida = Hive.box('partida');

  Map<Player, String> posicaoNaVitoria;

  Partida({this.posicaoNaVitoria});

  int salvarNoHive(Partida partida) {
    detalhesDaPartida.add(partida);
  }
}
