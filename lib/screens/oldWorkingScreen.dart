import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:placar_uno/models/jogatina.dart';
import 'adicionar_vitoria.dart';

class JogatinaEmAndamento extends StatefulWidget {
  @override
  _JogatinaEmAndamentoState createState() => _JogatinaEmAndamentoState();
}

class _JogatinaEmAndamentoState extends State<JogatinaEmAndamento> {
  bool mostrarTelaAddPlacar = false;
  Box boxJogatinaAtual;
  Box boxJogatinas;
  Jogatina jogatina;

  @override
  void initState() {
    super.initState();
    boxJogatinaAtual = Hive.box('jogatinaAtual');
    boxJogatinas = Hive.box('jogatinas');
    jogatina = boxJogatinas.getAt(boxJogatinaAtual.get('index'));
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(
                child: Text(mostrarTelaAddPlacar
                    ? "Fechar tela placar"
                    : "Abrir tela placar"),
                onPressed: () {
                  mostrarTelaAddPlacar = !mostrarTelaAddPlacar;
                  setState(() {});
                },
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                height: mostrarTelaAddPlacar ? 320 : 0,
                child: mostrarTelaAddPlacar ? AdicionarVitoria() : Text(''),
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      String jogador = jogatina.players[index];
                      return ListTile(
                        title: Text(jogador),
                        trailing: Text(jogatina
                                .pontuacaoTotalDosJogadores[jogador]
                                .toString() +
                            ' pontos'),
                        subtitle: Text(
                            'TODO, aqui vai quantas vezes vc ganhou em qual posição'),
                      );

                      // List keysInList = placarUnoBox.keys.toList();
                      // //print(index);
                      // //print(keysInList);
                      // //print(keysInList[index]);
                      // var key = keysInList[index];
                      // int placarTotal = placarUnoBox.get(key)['placarTotal'];
                      // return ListTile(
                      //   title: Text(keysInList[index]),
                      //   trailing: Text(placarTotal.toString() +
                      //       (placarTotal > 1 ? " pontos" : ' ponto')),
                      //   subtitle: Text(
                      //     getSingleScore(
                      //             pessoa: keysInList[index],
                      //             qualPlacar: 'primeiroLugar') +
                      //         getSingleScore(
                      //             pessoa: keysInList[index],
                      //             qualPlacar: 'segundoLugar') +
                      //         getSingleScore(
                      //             pessoa: keysInList[index],
                      //             qualPlacar: 'terceiroLugar') +
                      //         getSingleScore(
                      //             pessoa: keysInList[index],
                      //             qualPlacar: 'quartoLugar'),
                      //   ),
                      // );
                    },
                  );
                },
              ),
              Divider(
                color: Colors.orange,
                thickness: 2,
              ),
              SizedBox(height: 60),
              
            ],
          ),
        ),
      ),
    );
  }
}
