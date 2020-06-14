import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';

class ListarPartidas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final JogatinaController controller = Get.find();
    final List<Map<String, int>> partidasOrdemDescendente =
        controller.jogatinaModel.resultadoPartidas.reversed.toList();
    if (partidasOrdemDescendente.length == 0 ||
        partidasOrdemDescendente == null) {
      return Scaffold(
        body: Center(
          child: Text("Algum erro aconteceu, você não deveria estar aqui"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Partidas que já jogaram"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: partidasOrdemDescendente.length,
                itemBuilder: (_, int index) {
                  // String finalString = '';
                  // resultadoPartida.forEach((key, value) {
                  //   finalString += '$key venceu em $value lugar\n';
                  // });

                  int indexDisplay = partidasOrdemDescendente.length - index;

                  return ListTile(
                    title: Text(
                      index == 0
                          ? "Última partida jogada"
                          : "$indexDisplay\ª partida",
                    ),
                    onTap: () {
                      Get.toNamed(
                        'detalhes_partida',
                        arguments: indexDisplay - 1,
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.orange,
                  thickness: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
