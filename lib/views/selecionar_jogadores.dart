import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';
import '../models/jogatina_model.dart';

import 'jogatina_em_andamento.dart';

class ListarJogadores extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _nomeNovoPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha os jogadores:"),
      ),
      body: Container(
        child: GetBuilder<JogatinaController>(
          builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: controller.getListenableOfBox('jogadores'),
                    builder: (context, naoSei, child) {
                      Box boxJogadores = controller.getBox('jogadores');
                      return ListView.separated(
                        itemCount: boxJogadores.keys.toList().length,
                        itemBuilder: (BuildContext context, int index) {
                          String jogador = boxJogadores.getAt(index);
                          // print('ListView.separated item builder, nome player: ' + jogador);

                          controller.quaisEstaoSelecionados[jogador] ??= false;
                          return ListTile(
                            title: Text(jogador == null ? 'vazio' : jogador),
                            leading: Checkbox(
                                value:
                                    controller.quaisEstaoSelecionados[jogador],
                                onChanged: (bool isSelected) {
                                  controller.updateSelecionados(
                                      jogador, isSelected);
                                }),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                boxJogadores.deleteAt(index);
                              },
                            ),
                            onTap: () {
                              controller.quaisEstaoSelecionados[jogador] =
                                  !controller.quaisEstaoSelecionados[jogador];
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
                    onPressed: controller.criarNovaJogatina,
                    child: Text('Terminei de escolher'),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.dialog(
            Container(
              padding: EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Adicionar novo jogador'),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Nome'),
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          print('onSaved, value is:' + value);
                          _nomeNovoPlayer = value;
                        },
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        _formKey.currentState.save();
                        JogatinaController.to.addToBox(
                          boxName: 'jogadores',
                          value: _nomeNovoPlayer,
                        );
                        Navigator.pop(context);
                      },
                      child: Text('Salvar'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
