import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogadores_controller.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';

class ListarJogadores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha os jogadores:"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<JogatinaController>(
              builder: (jogatinaController) {
                return GetBuilder<JogadoresController>(
                  init: JogadoresController(),
                  builder: (jogadoresController) {
                    return ListView.separated(
                      itemCount: jogadoresController.boxJogadores.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        String jogador =
                            jogadoresController.boxJogadores.getAt(index);
                        // print('ListView.separated item builder, nome player: ' + jogador);

                        jogatinaController.selecionados[jogador] ??= false;
                        return CheckboxListTile(
                          value: jogatinaController.selecionados[jogador],
                          title: Text(jogador, style: TextStyle(fontSize: 20)),
                          onChanged: (isSelected) => jogatinaController
                              .alterarSelecionados(isSelected, jogador),
                          secondary: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              jogadoresController.boxJogadores.deleteAt(index);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return Divider(
                          color: Colors.orange,
                          thickness: 2,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () => JogatinaController.to.create(),
              child: Text('Terminei de escolher'),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.defaultDialog(
            title: "Adicionar Novo Jogador",
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text("Qual é o nome?"),
                  SizedBox(height: 10),
                  TextField(
                    controller: JogadoresController.to.textEditingController,
                    onSubmitted: (_) => JogadoresController.to.onSubmited,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Digite aqui...",
                    ),
                  ),
                ],
              ),
            ),
            confirm: RaisedButton(
              onPressed: JogadoresController.to.onSubmited,
              child: Text('Adicionar'),
            ),
            cancel: FlatButton(
              onPressed: () => Get.back(),
              child: Text("Cancelar"),
            ),
          );
        },
      ),
    );
  }
}
