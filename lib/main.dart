import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:placar_uno/AdicionarVitoria.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
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
  Box placarUnoBox;
  Map<String, dynamic> todosOsPlacares = {
    'alan': {
      'placarTotal': 0,
      'primeiroLugar': 0,
      'segundoLugar': 0,
      'terceiroLugar': 0,
      'quartoLugar': 0
    },
    'tomas': {
      'placarTotal': 0,
      'primeiroLugar': 0,
      'segundoLugar': 0,
      'terceiroLugar': 0,
      'quartoLugar': 0
    },
    'joao': {
      'placarTotal': 0,
      'primeiroLugar': 0,
      'segundoLugar': 0,
      'terceiroLugar': 0,
      'quartoLugar': 0
    },
    'guilherme': {
      'placarTotal': 1,
      'primeiroLugar': 0,
      'segundoLugar': 3,
      'terceiroLugar': 0,
      'quartoLugar': 0
    },
  };

  @override
  void initState() {
    super.initState();
    placarUnoBox = Hive.box("placarUno");
    if (placarUnoBox.get('alan') == null) {
      placarUnoBox.put('alan', {
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
        title: Text("placar do Uno"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.orange,
                  thickness: 2,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: placarUnoBox.keys.toList().length,
                itemBuilder: (BuildContext context, int index) {
                  List keysInList = placarUnoBox.keys.toList();
                  print(index);
                  print(keysInList[index]);
                  return ListTile(
                    title: Text(keysInList[index]),
                    trailing: Text(placarUnoBox.get(
                            [keysInList[index]])['placarTotal'].toString() +
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
              ),
              RaisedButton(
                onPressed: () {
                  adicionarVitoria = !adicionarVitoria;
                  setState(() {});
                },
              ),
              adicionarVitoria
                  ? AdicionarVitoria()
                  : Text('clique para adicionar vitoria')
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
