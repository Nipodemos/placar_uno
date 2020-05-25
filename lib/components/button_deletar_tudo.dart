import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RaisedButtonDeletarTudo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box placarUnoBox = Hive.box('placarUno');
    return RaisedButton(
      child: Text('Deletar TUDO'),
      onPressed: () {
        if (placarUnoBox.get('alan') != null) {
          placarUnoBox.put('alan', {
            'placarTotal': 0,
            'primeiroLugar': 0,
            'segundoLugar': 0,
            'terceiroLugar': 0,
            'quartoLugar': 0
          });
        }
        if (placarUnoBox.get('guilherme') != null) {
          placarUnoBox.put('guilherme', {
            'placarTotal': 0,
            'primeiroLugar': 0,
            'segundoLugar': 0,
            'terceiroLugar': 0,
            'quartoLugar': 0
          });
        }
        if (placarUnoBox.get('joao') != null) {
          placarUnoBox.put('joao', {
            'placarTotal': 0,
            'primeiroLugar': 0,
            'segundoLugar': 0,
            'terceiroLugar': 0,
            'quartoLugar': 0
          });
        }
        if (placarUnoBox.get('tomas') != null) {
          placarUnoBox.put('tomas', {
            'placarTotal': 0,
            'primeiroLugar': 0,
            'segundoLugar': 0,
            'terceiroLugar': 0,
            'quartoLugar': 0
          });
        }
      },
    );
  }
}
