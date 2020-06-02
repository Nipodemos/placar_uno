import 'package:flutter/material.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';
import 'package:placar_uno/views/jogatina_acabou.dart';

import 'package:get/get.dart';

import 'definir_vencedores.dart';

class JogatinaEmAndamentoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JogatinaController>(() => JogatinaController());
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Placar do Uno"),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(8),
            child: RaisedButton(
              child: Text('Acabou a jogatina'),
              onPressed: () {
                Get.offAllNamed('jogatina_acabou');
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.blueGrey[100],
                child: ValueListenableBuilder(
                  valueListenable: JogatinaController.to.getListenable(),
                  builder: (context, value, child) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.orange,
                        thickness: 2,
                      ),
                      shrinkWrap: true,
                      itemCount:
                          JogatinaController.to.jogatinaModel.jogadores.length,
                      itemBuilder: (BuildContext context, int index) {
                        String jogador = JogatinaController
                            .to.jogatinaModel.jogadores[index];
                        JogatinaController.to
                            .calcularPontuacaoTotalDosJogadores();
                        int pontuacaoTotal = JogatinaController
                            .to.pontuacaoTotalDosJogadores[jogador];
                        return ListTile(
                          title: Text(
                            jogador,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          trailing: Text(
                            pontuacaoTotal.toString() +
                                (pontuacaoTotal < 2 ? ' ponto' : 'pontos'),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
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
              child: Text('Terminou uma partida'),
              onPressed: () {
                Get.toNamed('definir_vencedores');
              },
            ),
          ],
        ),
      ),
    );
  }
}
