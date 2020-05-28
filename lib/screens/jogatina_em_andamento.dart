import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:placar_uno/screens/jogatina_acabou.dart';
import 'package:supercharged/supercharged.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placar_uno/models/jogatina.dart';

import 'definir_vencedores.dart';

class JogatinaEmAndamento extends StatelessWidget {
  /// Pega a quantidade de vezes que o jogador venceu em cada posição
  ///
  /// Primeio preciso dar um loop sobre cada partida
  /// em cada partida eu pego a posição que ele venceu
  /// e vou adicionando a um contador
  /// no final fica algo tipo assim
  /// a esquer a posição, a direita a quantidade de vezes
  /// que o jogador venceu na posição
  /// ```json
  /// {
  ///   1: 3
  ///   2: 5
  ///   3: 0
  ///   4: 2
  /// }
  /// ```
  ///
  /// depois é tudo convertido para uma string
  String pegarAsVitorias({String jogador, Jogatina jogatina}) {
    Map<int, int> quaisPosicoes;
    String finalString = '';

    jogatina.resultadoPartidas.forEach((partida) {
      int posicaoNaPartidaAtual = partida[jogador];
      quaisPosicoes[posicaoNaPartidaAtual]++;
    });
    for (var i = 1; i <= jogatina.jogadores.length; i++) {
      finalString += 'Venceu ${quaisPosicoes[i] ?? 0} vezes em $i\º lugar\n';
    }

    // removendo o último \n da string, já que criaria uma linha em branco
    // desnecessária
    return finalString.allBefore(RegExp("\\n\$"));
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> pontuacaoTotalDosJogadores = {};

    final Box boxJogatinaAtual = Hive.box('jogatinaAtual');
    final Box boxJogatinas = Hive.box('jogatinas');
    final int indexJogatinaAtual = boxJogatinaAtual.get('indice');
    Jogatina jogatina = boxJogatinas.getAt(indexJogatinaAtual);

    jogatina.resultadoPartidas.forEach((Map<String, int> partida) {
      partida.forEach((nomeJogador, posicaoNaPartida) {
        pontuacaoTotalDosJogadores[nomeJogador] +=
            (jogatina.jogadores.length - posicaoNaPartida + 1);
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Placar do Uno"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            RaisedButton(
              child: Text("Terminou uma partida"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DefinirVencedores()),
                );
              },
            ),
            Expanded(
              child: Card(
                color: Colors.blueGrey[100],
                child: ValueListenableBuilder(
                  valueListenable: boxJogatinas.listenable(),
                  builder: (context, value, child) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.orange,
                        thickness: 2,
                      ),
                      shrinkWrap: true,
                      itemCount: jogatina.jogadores.length,
                      itemBuilder: (BuildContext context, int index) {
                        String jogador = jogatina.jogadores[index];
                        return ListTile(
                          title: Text(jogador),
                          trailing: Text(
                            pontuacaoTotalDosJogadores[jogador].toString() +
                                ' pontos',
                          ),
                          subtitle: Text(
                            pegarAsVitorias(jogador: jogador),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            RaisedButton(
              child: Text('Enjoamos de jogar'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EstatisticasDaJogatinaAcabada(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
