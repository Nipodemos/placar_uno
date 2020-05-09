import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:placar_uno/AdicionarVitoria.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  await Hive.openBox<Map>("placarUno");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListaDeJogadores(),
    );
  }
}

class ListaDeJogadores extends StatefulWidget {
  @override
  _ListaDeJogadoresState createState() => _ListaDeJogadoresState();
}

class _ListaDeJogadoresState extends State<ListaDeJogadores> {
  Box<Map> placarUnoBox;

  @override
  void initState() {
    super.initState();
    placarUnoBox = Hive.box<Map>("placarUno");
    if (placarUnoBox.get('alan') == null) {
      placarUnoBox.put('alan', {
        'placarTotal': 0,
        'primeiroLugar': 0,
        'segundoLugar': 0,
        'terceiroLugar': 0,
        'quartoLugar': 0
      });
    }
    if (placarUnoBox.get('guilherme') == null) {
      placarUnoBox.put('guilherme', {
        'placarTotal': 0,
        'primeiroLugar': 0,
        'segundoLugar': 0,
        'terceiroLugar': 0,
        'quartoLugar': 0
      });
    }
    if (placarUnoBox.get('joao') == null) {
      placarUnoBox.put('joao', {
        'placarTotal': 0,
        'primeiroLugar': 0,
        'segundoLugar': 0,
        'terceiroLugar': 0,
        'quartoLugar': 0
      });
    }
    if (placarUnoBox.get('tomas') == null) {
      placarUnoBox.put('tomas', {
        'placarTotal': 0,
        'primeiroLugar': 0,
        'segundoLugar': 0,
        'terceiroLugar': 0,
        'quartoLugar': 0
      });
    }
  }

  bool adicionarVitoria = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Placar do Uno"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder(
                valueListenable: placarUnoBox.listenable(),
                builder: (context, value, child) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.orange,
                      thickness: 2,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: placarUnoBox.keys.toList().length,
                    itemBuilder: (BuildContext context, int index) {
                      List keysInList = placarUnoBox.keys.toList();
                      //print(index);
                      //print(keysInList);
                      //print(keysInList[index]);
                      var key = keysInList[index];
                      return ListTile(
                        title: Text(keysInList[index]),
                        trailing: Text(
                            placarUnoBox.get(key)['placarTotal'].toString() +
                                " pontos"),
                        subtitle: Text(
                          getSingleScore(
                                  pessoa: keysInList[index],
                                  qualPlacar: 'primeiroLugar') +
                              getSingleScore(
                                  pessoa: keysInList[index],
                                  qualPlacar: 'segundoLugar') +
                              getSingleScore(
                                  pessoa: keysInList[index],
                                  qualPlacar: 'terceiroLugar') +
                              getSingleScore(
                                  pessoa: keysInList[index],
                                  qualPlacar: 'quartoLugar'),
                        ),
                      );
                    },
                  );
                },
              ),
              RaisedButton(
                onPressed: () {
                  adicionarVitoria = !adicionarVitoria;
                  setState(() {});
                },
              ),
              adicionarVitoria
                  ? AdicionarVitoria()
                  : Text('clique para adicionar vitoria'),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: RaisedButton(
                  onPressed: () {
                    if (placarUnoBox.get('alan') != null) {
                      placarUnoBox.put('alan', {
                        'placarTotal': 0,
                        'primeiroLugar': 0,
                        'segundoLugar': 0,
                        'terceiroLugar': 0,
                        'quartoLugar': 0
                      });
                    }
                    if (placarUnoBox.get('guilherme') != null) {
                      placarUnoBox.put('guilherme', {
                        'placarTotal': 0,
                        'primeiroLugar': 0,
                        'segundoLugar': 0,
                        'terceiroLugar': 0,
                        'quartoLugar': 0
                      });
                    }
                    if (placarUnoBox.get('joao') != null) {
                      placarUnoBox.put('joao', {
                        'placarTotal': 0,
                        'primeiroLugar': 0,
                        'segundoLugar': 0,
                        'terceiroLugar': 0,
                        'quartoLugar': 0
                      });
                    }
                    if (placarUnoBox.get('tomas') != null) {
                      placarUnoBox.put('tomas', {
                        'placarTotal': 0,
                        'primeiroLugar': 0,
                        'segundoLugar': 0,
                        'terceiroLugar': 0,
                        'quartoLugar': 0
                      });
                    }
                  },
                  child: Text('Deletar TUDO'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getSingleScore({String pessoa, String qualPlacar}) {
    int temp = placarUnoBox.get(pessoa)[qualPlacar];
    Map keyToString = {
      'primeiroLugar': '1º',
      'segundoLugar': '2º',
      'terceiroLugar': '3º',
      'quartoLugar': '4º',
    };
    if (pessoa.isEmpty || pessoa == null) {
      return "vc esqueceu o argumento 'pessoa'";
    } else if (qualPlacar.isEmpty || qualPlacar == null) {
      return "vc esqueceu o argumento 'qualPlacar'";
    } else {
      if (temp == 0 || temp == 1) {
        return "$temp vitória   no ${keyToString[qualPlacar]} lugar\n";
      } else if (temp > 1) {
        return "$temp vitórias no ${keyToString[qualPlacar]} lugar\n";
      } else {
        return "Erro não esperado";
      }
    }
  }
}
