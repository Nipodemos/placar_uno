import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supercharged/supercharged.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placar_uno/models/jogatina.dart';

import 'definir_vencedores.dart';

class JogatinaEmAndamento extends StatefulWidget {
  @override
  _JogatinaEmAndamentoState createState() => _JogatinaEmAndamentoState();
}

class _JogatinaEmAndamentoState extends State<JogatinaEmAndamento> {
  num indexJogatinaAtual;
  Box boxJogatinaAtual;
  Box boxJogatinas;
  Jogatina jogatina;
  Map<String, int> pontuacaoTotalDosJogadores = {};

  @override
  void initState() {
    super.initState();

    boxJogatinaAtual = Hive.box('jogatinaAtual');
    boxJogatinas = Hive.box('jogatinas');
    indexJogatinaAtual = boxJogatinaAtual.get('indice') as num;
    jogatina = boxJogatinas.getAt(indexJogatinaAtual);
    jogatina.jogadores.forEach((jogador) {
      pontuacaoTotalDosJogadores[jogador] = 0;
    });

    jogatina.partidas.forEach((Map<String, int> partida) {
      partida.forEach((nomeJogador, posicaoNaPartida) {
        pontuacaoTotalDosJogadores[nomeJogador] +=
            (jogatina.jogadores.length - posicaoNaPartida + 1);
      });
    });
  }

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
  String pegarAsVitorias({String jogador}) {
    String finalString = '';
    Map<int, int> quaisPosicoes = {};
    jogatina.partidas.forEach((partida) {
      int posicaoAtual = partida[jogador];
      //quando for null, começa com 0 pra poder usar o ++
      quaisPosicoes[posicaoAtual] ??= 0;
      quaisPosicoes[posicaoAtual]++;
    });
    for (var i = 1; i <= jogatina.jogadores.length; i++) {
      finalString += 'Venci ${quaisPosicoes[i]} vezes em $i\º lugar\n';
    }

    // removendo o último \n da string, já que criaria uma linha em branco
    // desnecessária
    return finalString.allBefore(RegExp("\\n\$"));
  }

  @override
  Widget build(BuildContext context) {
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
            Divider(
              color: Colors.orange,
              thickness: 2,
            ),
            ValueListenableBuilder(
              valueListenable: boxJogatinas.listenable(),
              builder: (context, value, child) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.orange,
                    thickness: 2,
                  ),
                  shrinkWrap: true,
                  itemCount: jogatina.quantidadeDejogadores,
                  itemBuilder: (BuildContext context, int index) {
                    String jogador = jogatina.jogadores[index];
                    return ListTile(
                      title: Text(jogador),
                      trailing: Text(
                          pontuacaoTotalDosJogadores[jogador].toString() +
                              ' pontos'),
                      subtitle: Text(pegarAsVitorias(jogador: jogador)),
                    );
                  },
                );
              },
            ),
            Divider(
              color: Colors.orange,
              thickness: 2,
            ),
            SizedBox(height: 60),
            RaisedButton(
              child: Text('Enjoamos de jogar'),
              onPressed: () {
                boxJogatinaAtual.delete('indice');
              },
            ),
          ],
        ),
      ),
    );
  }
}
