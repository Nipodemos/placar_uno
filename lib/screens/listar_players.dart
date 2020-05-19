import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placar_uno/models/player.dart';

class ListarPlayers extends StatefulWidget {
  @override
  _ListarPlayersState createState() => _ListarPlayersState();
}

class _ListarPlayersState extends State<ListarPlayers> {
  List<Player> allPlayers;
  int contagemDePlayers;
  Player playerModel;
  Map<String, bool> whichOnesAreSelected;

  final _formKey = GlobalKey<FormState>();
  String _nomeNovoPlayer;

  @override
  void initState() {
    allPlayers = playerModel.getAllPlayers();
    contagemDePlayers = allPlayers.length;
    whichOnesAreSelected = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: playerModel.getBoxListenable(),
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
                      itemBuilder: (BuildContext context, int index) {
                        Player player = allPlayers[index];
                        print('item builder, nome player: ' +
                            player.nome.toString());
                        whichOnesAreSelected[player.nome] ??= false;
                        return ListTile(
                          title:
                              Text(player.nome == null ? 'vazio' : player.nome),
                          leading: Checkbox(
                              value: whichOnesAreSelected[player.nome],
                              onChanged: (bool onOff) {
                                setState(() {
                                  whichOnesAreSelected[player.nome] = onOff;
                                });
                              }),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              player.delete();
                            },
                          ),
                          onTap: () {
                            setState(() {
                              whichOnesAreSelected[player.nome] =
                                  !whichOnesAreSelected[player.nome];
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
                      itemCount: allPlayers.length),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {},
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
                              Player(nome: _nomeNovoPlayer)..save();

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
