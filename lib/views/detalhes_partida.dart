import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';

class DetalhesPartida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final JogatinaController controller = Get.find();
    int indexPartida = Get.arguments;
    final Map<String, int> partida = controller.jogatinaModel
        .resultadoPartidas[indexPartida ?? 0]; //TODO: TIRAR ESSE ZERO PELO AMOR
    final List<String> jogadores = partida.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da partida"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text("Partida ${indexPartida + 1}"),
            Expanded(
              child: ListView.separated(
                itemCount: jogadores.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: Text(jogadores[index]),
                    trailing: Text(
                      "Venceu em ${partida[jogadores[index]]}º lugar",
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.orange,
                  thickness: 2,
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Get.offNamed('definir_vencedores', arguments: indexPartida);
              },
              child: Text("Editar partida"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Excluir partida"),
            ),
          ],
        ),
      ),
    );
  }
}
