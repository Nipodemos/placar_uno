import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogatina_generica_controller.dart';

class DescreverJogatinas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          appBar: AppBar(),
          body: GetBuilder<JogatinaControllerGenerica>(
            init: JogatinaControllerGenerica(),
            builder: (controller) {
              final int index = Get.arguments as int;
              var jogatinaModel = controller.getJogatinaModel(index: index);
              return Column(
                children: [
                  Row(
                    children: [
                      Text("Quantidade de jogadores: "),
                      Text(jogatinaModel.jogadores.length.toString())
                    ],
                  ),
                  Row(
                    children: [
                      Text("Quantidade de partidas: "),
                      Text(
                        jogatinaModel.resultadoPartidas.length.toString(),
                      )
                    ],
                  ),
                  Text(
                    "completado: " + (jogatinaModel.completado ? "Sim" : "Não"),
                  ),
                  Text("Jogadores:"),
                  Expanded(
                    child: ListView.builder(
                      itemCount: jogatinaModel.jogadores.length,
                      itemBuilder: (_, i) {
                        return ListTile(
                          title: Text(jogatinaModel.jogadores[i]),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
