import 'package:flutter/material.dart';
void main() {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("placar do Uno"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todosOsPlacares.keys.toList().length,
                itemBuilder: (BuildContext context, int index) {
                  List keysInList = todosOsPlacares.keys.toList();
                  print(index);
                  print(keysInList[index]);
                  return ListTile(
                    title: Text(keysInList[index]),
                    trailing: Text(todosOsPlacares[keysInList[index]]
                                ['placarTotal']
                            .toString() +
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
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    Map seletorLugar = {
                      'alan': 0,
                      'guilherme': 0,
                      'joao': 0,
                      'tomas': 0
                    };
                    return StatefulBuilder(
                      builder: (ct, setState) {
                        String message = "";
                        return Dialog(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Alan'),
                                    Radio(
                                      groupValue: seletorLugar['alan'],
                                      value: 1,
                                      onChanged: (value) {
                                        seletorLugar['alan'] = value;
                                        print(value);
                                        setState(() {});
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['alan'],
                                      value: 2,
                                      onChanged: (value) {
                                        seletorLugar['alan'] = value;
                                        print(value);
                                        setState(() {});
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['alan'],
                                      value: 3,
                                      visualDensity: VisualDensity(
                                          horizontal:
                                              VisualDensity.maximumDensity),
                                      onChanged: (value) {
                                        print(value);
                                        seletorLugar['alan'] = value;
                                        setState(() {});
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['alan'],
                                      value: 4,
                                      onChanged: (value) {
                                        print(value);
                                        seletorLugar['alan'] = value;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Guilherme'),
                                    Radio(
                                      groupValue: seletorLugar['guilherme'],
                                      value: 1,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['guilherme'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['guilherme'],
                                      value: 2,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['guilherme'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['guilherme'],
                                      value: 3,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['guilherme'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['guilherme'],
                                      value: 4,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['guilherme'] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Joao'),
                                    Radio(
                                      groupValue: seletorLugar['joao'],
                                      value: 1,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['joao'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['joao'],
                                      value: 2,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['joao'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['joao'],
                                      value: 3,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['joao'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['joao'],
                                      value: 4,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['joao'] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('tomas'),
                                    Radio(
                                      groupValue: seletorLugar['tomas'],
                                      value: 1,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['tomas'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['tomas'],
                                      value: 2,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['tomas'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['tomas'],
                                      value: 3,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          seletorLugar['tomas'] = value;
                                        });
                                      },
                                    ),
                                    Radio(
                                      groupValue: seletorLugar['tomas'],
                                      value: 4,
                                      onChanged: (value) {
                                        setState(() {
                                          seletorLugar['tomas'] = value;
                                          print(seletorLugar);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(message),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      child: Text("Cancelar"),
                                      onPressed: () {
                                        // TODO
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Divider(),
                                    RaisedButton(
                                      child: Text("Confirmar"),
                                      onPressed: () {
                                        const Map numberToKey = {
                                          1: 'primeiroLugar',
                                          2: 'segundoLugar',
                                          3: 'terceiroLugar',
                                          4: 'quartoLugar'
                                        };
                                        if (seletorLugar['alan'] >= 1 &&
                                            seletorLugar['guilherme'] >= 1 &&
                                            seletorLugar['joao'] >= 1 &&
                                            seletorLugar['tomas'] >= 1) {
                                          todosOsPlacares['alan'][numberToKey[
                                              seletorLugar['alan']]]++;
                                          todosOsPlacares['guilherme'][
                                              numberToKey[
                                                  seletorLugar['guilherme']]]++;
                                          todosOsPlacares['joao'][numberToKey[
                                              seletorLugar['joao']]]++;
                                          todosOsPlacares['tomas'][numberToKey[
                                              seletorLugar['tomas']]]++;
                                          print(
                                              'ao que tudo indica, deu certo');
                                          print(todosOsPlacares);
                                          message =
                                              "Feito! parabens aos vencedores!";
                                              setState(() {});
                                          Navigator.pop(context);
                                        } else {
                                          print('algum valor ta vazio');
                                          message = "algum valor ta vazio";
                                          setState(() {});
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  String getSingleScore({String pessoa, String qualPlacar}) {
    int temp = todosOsPlacares[pessoa][qualPlacar];
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

