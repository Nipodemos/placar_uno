import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:placar_uno/models/jogatina_model.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

import 'home_page.dart';

class JogatinaAcabou extends StatelessWidget {
  String stringfyPontosDosVencedores(JogatinaModel jogatina) {
    Map<String, int> pontuacaoTotalDosJogadores = {};

    if (jogatina.resultadoPartidas.length < 1) {
      return "Nenhuma partida foi jogada, portanto ninguem fez ponto";
    } else {
      jogatina.resultadoPartidas.forEach((Map<String, int> partida) {
        partida.forEach((nomeJogador, posicaoNaPartida) {
          pontuacaoTotalDosJogadores[nomeJogador] ??= 0;
          pontuacaoTotalDosJogadores[nomeJogador] +=
              (jogatina.jogadores.length - posicaoNaPartida + 1);
        });
      });

      String finalString = '';

      List<MapEntry> listaPontuacaoJogadores =
          pontuacaoTotalDosJogadores.entries.toList();
      listaPontuacaoJogadores.sort((elementoa, elementob) {
        return elementoa.value.compareTo(elementob.value);
      });
      listaPontuacaoJogadores = listaPontuacaoJogadores.reversed;
      listaPontuacaoJogadores.forEach((MapEntry jogadorInfo) {
        finalString += '${jogadorInfo.key} fez ${jogadorInfo.value} pontos\n';
      });
      return finalString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Box boxJogatinaAtual = Hive.box('jogatinaAtual');
    final int indexJogatinaAtual = boxJogatinaAtual.get('indice');
    if (indexJogatinaAtual != null) {
      final Box boxJogatinas = Hive.box('jogatinas');
      JogatinaModel jogatina = boxJogatinas.getAt(indexJogatinaAtual);
      jogatina.dataFim = DateTime.now();

      jogatina.completado = true;
      jogatina.salvar(index: indexJogatinaAtual);
      boxJogatinaAtual.delete('indice');
      return Scaffold(
        appBar: AppBar(
          title: Text('Tudo sobre essa jogatina'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                  'Vocês jogaram ${jogatina.resultadoPartidas.length} partidas'),
              Text(
                'A partida começou ${TimeAgo.format(jogatina.dataInicio, locale: "ptbr")}',
              ),
              Text(
                stringfyPontosDosVencedores(jogatina),
              ),
              Text('Espero que tenham se divertido!')
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Text(
                'Você não deveria estar nessa tela, não tem nenhuma jogatina que acabou de acabar',
              ),
              RaisedButton(
                child: Text('Voltar para HomePage'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
