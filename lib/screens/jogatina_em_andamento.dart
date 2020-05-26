import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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

  // String getSingleScore({String pessoa, String qualPlacar}) {
  //   //print('func getSingleScore, pessoa: $pessoa, qualPlacar: $qualPlacar');
  //   int contagemVitorias = placarUnoBox.get(pessoa)[qualPlacar];
  //   Map keyToString = {
  //     'primeiroLugar': '1º',
  //     'segundoLugar': '2º',
  //     'terceiroLugar': '3º',
  //     'quartoLugar': '4º',
  //   };
  //   if (pessoa.isEmpty || pessoa == null) {
  //     return "vc esqueceu o argumento 'pessoa'";
  //   } else if (qualPlacar.isEmpty || qualPlacar == null) {
  //     return "vc esqueceu o argumento 'qualPlacar'";
  //   } else {
  //     if (contagemVitorias == 0 || contagemVitorias == 1) {
  //       return "$contagemVitorias vitória   no ${keyToString[qualPlacar]} lugar\n";
  //     } else if (contagemVitorias > 1) {
  //       return "$contagemVitorias vitórias no ${keyToString[qualPlacar]} lugar\n";
  //     } else {
  //       return "Erro não esperado";
  //     }
  //   }
  // }

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
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DefinirVencedores()),
                ).then((_) {
                  setState(() {});
                });
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
                      subtitle: Text(
                          // TODO fazer isso aqui
                          'TODO, aqui vai quantas vezes vc ganhou em qual posição'),
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
