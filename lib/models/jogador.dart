import 'package:hive/hive.dart';

part 'jogador.g.dart';

@HiveType(typeId: 0)
class Jogador {
  @HiveField(0)
  String nome;

  Jogador({this.nome});
}
