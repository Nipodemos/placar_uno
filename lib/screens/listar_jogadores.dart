import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placar_uno/models/jogatina.dart';

import 'oldWorkingScreen.dart';

class ListarJogadores extends StatefulWidget {
  @override
  _ListarJogadoresState createState() => _ListarJogadoresState();
}

class _ListarJogadoresState extends State<ListarJogadores> {
  Box boxJogadores;
  int contagemDePlayers;
  Map<String, bool> quaisEstaoSelecionados;

  final _formKey = GlobalKey<FormState>();
  String _nomeNovoPlayer;

  @override
  void initState() {
    boxJogadores = Hive.box('jogadores');
    quaisEstaoSelecionados = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxJogadores.listenable(),
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Escolha os jogadores:"),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: boxJogadores.keys.toList().length,
                    itemBuilder: (BuildContext context, int index) {
                      String jogador = boxJogadores.getAt(index);
                      // print('ListView.separated item builder, nome player: ' + jogador);

                      quaisEstaoSelecionados[jogador] ??= false;
                      return ListTile(
                        title: Text(jogador == null ? 'vazio' : jogador),
                        leading: Checkbox(
                            value: quaisEstaoSelecionados[jogador],
                            onChanged: (bool onOff) {
                              setState(() {
                                quaisEstaoSelecionados[jogador] = onOff;
                              });
                            }),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            boxJogadores.deleteAt(index);
                          },
                        ),
                        onTap: () {
                          setState(() {
                            quaisEstaoSelecionados[jogador] =
                                !quaisEstaoSelecionados[jogador];
                          });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.orange,
                        thickness: 2,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      List<String> jogadoresSelecionados = [];
                      quaisEstaoSelecionados.forEach((key, value) {
                        if (value == true) jogadoresSelecionados.add(key);
                      });
                      print(jogadoresSelecionados);
                      Jogatina jogatina =
                          Jogatina(jogadores: jogadoresSelecionados);
                      Box boxJogatinaAtual = Hive.box('jogatinaAtual');
                      int indexJogatinaAtual;
                      jogatina.salvar().then((value) {
                        indexJogatinaAtual = value;
                        boxJogatinaAtual.delete('index');

                        boxJogatinaAtual.put('indice', indexJogatinaAtual);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JogatinaEmAndamento()),
                        );
                      });
                    },
                    child: Text('Terminei de escolher'),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
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
                                return _nomeNovoPlayer = value;
                              },
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              _formKey.currentState.save();
                              boxJogadores.add(_nomeNovoPlayer);

                              Navigator.pop(context);
                            },
                            child: Text('Salvar'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
