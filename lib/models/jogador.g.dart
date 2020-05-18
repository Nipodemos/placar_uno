// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jogador.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JogadorAdapter extends TypeAdapter<Jogador> {
  @override
  final typeId = 0;

  @override
  Jogador read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Jogador(
      nome: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Jogador obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.nome);
  }
}
