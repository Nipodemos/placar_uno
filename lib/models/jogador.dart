import 'package:hive/hive.dart';

part 'jogador.g.dart';

@HiveType(typeId: 0)
class Jogador {
  Jogador({this.nome});

  @HiveField(0)
  String nome;
}
