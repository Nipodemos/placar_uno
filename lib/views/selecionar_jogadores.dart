import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogadores_controller.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

class JogadoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JogadoresController>(() => JogadoresController());
  }
}

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
            child: ValueListenableBuilder(
              valueListenable: JogadoresController.to.boxJogadores.listenable(),
              builder: (context, _, child) {
                return ListView.separated(
                  itemCount: JogadoresController.to.boxJogadores.values
                      .toList()
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    String jogador =
                        JogadoresController.to.boxJogadores.getAt(index);
                    // print('ListView.separated item builder, nome player: ' + jogador);

                    JogadoresController.to.selecionados[jogador] ??= false;
                    return ListTile(
                      title: Text(jogador, style: TextStyle(fontSize: 20)),
                      leading: Checkbox(
                        value: JogadoresController.to.selecionados[jogador],
                        onChanged: (bool isSelected) {
                          JogadoresController.to.selecionados[jogador] =
                              isSelected;
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          JogadoresController.to.boxJogadores.deleteAt(index);
                        },
                      ),
                      onTap: () {
                        JogadoresController.to.selecionados[jogador] =
                            !JogadoresController.to.selecionados[jogador];
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.orange,
                      thickness: 2,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: JogatinaController.to.criarNovaJogatina,
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
                onPressed: () => Get.back(), child: Text("Cancelar")),
          );
        },
      ),
    );
  }
}
