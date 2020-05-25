// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jogatina.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JogatinaAdapter extends TypeAdapter<Jogatina> {
  @override
  final typeId = 2;

  @override
  Jogatina read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Jogatina(
      players: (fields[5] as List)?.cast<String>(),
    )
      ..quantidadeDePartidas = fields[0] as int
      ..dataInicio = fields[1] as DateTime
      ..dataFim = fields[2] as DateTime
      ..partidas = (fields[3] as List)
          ?.map((dynamic e) => (e as Map)?.cast<String, int>())
          ?.toList()
      ..pontuacaoTotalDosJogadores = (fields[4] as Map)?.cast<String, int>()
      ..quantidadeDePlayers = fields[6] as int
      ..completado = fields[7] as bool;
  }

  @override
  void write(BinaryWriter writer, Jogatina obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.quantidadeDePartidas)
      ..writeByte(1)
      ..write(obj.dataInicio)
      ..writeByte(2)
      ..write(obj.dataFim)
      ..writeByte(3)
      ..write(obj.partidas)
      ..writeByte(4)
      ..write(obj.pontuacaoTotalDosJogadores)
      ..writeByte(5)
      ..write(obj.players)
      ..writeByte(6)
      ..write(obj.quantidadeDePlayers)
      ..writeByte(7)
      ..write(obj.completado);
  }
}
