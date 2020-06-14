import 'package:flutter/material.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';

import 'package:get/get.dart';

class JogatinaEmAndamento extends StatelessWidget {
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
                Get.offNamed('jogatina_acabou');
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
                    print(JogatinaController.to.jogatinaModel.toString());
                    int lengthJogadores =
                        JogatinaController.to.jogatinaModel.jogadores.length;
                    print("length Jogadores: $lengthJogadores");
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.orange,
                        thickness: 2,
                      ),
                      shrinkWrap: true,
                      itemCount: lengthJogadores,
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
                                (pontuacaoTotal < 2 ? ' ponto' : ' pontos'),
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
            Row(
              children: [
                RaisedButton(
                  child: Text('Terminou uma partida'),
                  onPressed: () {
                    Get.toNamed('definir_vencedores');
                  },
                ),
                SizedBox(width: 16),
                RaisedButton(
                  child: Text("Listar partidas"),
                  onPressed: JogatinaController
                              .to.jogatinaModel.resultadoPartidas.length ==
                          0
                      ? null
                      : () {
                          Get.toNamed('listar_partidas');
                        },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
