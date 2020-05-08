import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum grupoAlan { primeiroLugar, segundoLugar, terceiroLugar, quartoLugar }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      'segundoLugar': 2,
      'terceiroLugar': 0,
      'quartoLugar': 0
    },
    'joao': {
      'placarTotal': 4,
      'primeiroLugar': 0,
      'segundoLugar': 0,
      'terceiroLugar': 0,
      'quartoLugar': 0
    },
    'guilherme': {
      'placarTotal': 0,
      'primeiroLugar': 0,
      'segundoLugar': 0,
      'terceiroLugar': 0,
      'quartoLugar': 0
    },
  };

  Map seletorLugar = {'alan': 0, 'guilherme': 0, 'joao': 0, 'tomas': 0};

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
        return "$temp vitória   no ${keyToString[qualPlacar]} lugar";
      } else if (temp > 1) {
        return "$temp vitórias no ${keyToString[qualPlacar]} lugar";
      } else {
        return "Erro não esperado";
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: [
              ListTile(
                title: Text("Alan"),
                trailing: Text(
                    todosOsPlacares['alan']['placarTotal'].toString() +
                        " pontos"),
                subtitle: Text(
                    "${getSingleScore(pessoa: 'alan', qualPlacar: 'primeiroLugar')}\n"
                    "${getSingleScore(pessoa: 'alan', qualPlacar: 'segundoLugar')}\n"
                    "${getSingleScore(pessoa: 'alan', qualPlacar: 'terceiroLugar')}\n"
                    "${getSingleScore(pessoa: 'alan', qualPlacar: 'quartoLugar')}\n"),
              ),
              Divider(
                color: Colors.orange,
                thickness: 2,
              ),
              ListTile(
                title: Text("Guilherme"),
                trailing: Text(
                    todosOsPlacares['guilherme']['placarTotal'].toString() +
                        " pontos"),
                subtitle: Text(
                    "${getSingleScore(pessoa: 'guilherme', qualPlacar: 'primeiroLugar')}\n"
                    "${getSingleScore(pessoa: 'guilherme', qualPlacar: 'segundoLugar')}\n"
                    "${getSingleScore(pessoa: 'guilherme', qualPlacar: 'terceiroLugar')}\n"
                    "${getSingleScore(pessoa: 'guilherme', qualPlacar: 'quartoLugar')}\n"),
              ),
              Divider(
                color: Colors.orange,
                thickness: 2,
              ),
              ListTile(
                title: Text("João"),
                trailing: Text(
                    todosOsPlacares['joao']['placarTotal'].toString() +
                        " pontos"),
                subtitle: Text(
                    "${getSingleScore(pessoa: 'joao', qualPlacar: 'primeiroLugar')}\n"
                    "${getSingleScore(pessoa: 'joao', qualPlacar: 'segundoLugar')}\n"
                    "${getSingleScore(pessoa: 'joao', qualPlacar: 'terceiroLugar')}\n"
                    "${getSingleScore(pessoa: 'joao', qualPlacar: 'quartoLugar')}\n"),
              ),
              Divider(
                color: Colors.orange,
                thickness: 2,
              ),
              ListTile(
                title: Text("Tomás"),
                trailing: Text(
                    todosOsPlacares['tomas']['placarTotal'].toString() +
                        " pontos"),
                subtitle: Text(
                    "${getSingleScore(pessoa: 'tomas', qualPlacar: 'primeiroLugar')}\n"
                    "${getSingleScore(pessoa: 'tomas', qualPlacar: 'segundoLugar')}\n"
                    "${getSingleScore(pessoa: 'tomas', qualPlacar: 'terceiroLugar')}\n"
                    "${getSingleScore(pessoa: 'tomas', qualPlacar: 'quartoLugar')}\n"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Dialog(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Alan'),
                              Radio(
                                groupValue: seletorLugar['alan'],
                                value: grupoAlan.primeiroLugar,
                                onChanged: (value) {
                                  seletorLugar['alan'] = value;
                                  print(value);
                                  setState(() {});
                                },
                              ),
                              Radio(
                                groupValue: seletorLugar['alan'],
                                value: grupoAlan.segundoLugar,
                                onChanged: (value) {
                                  seletorLugar['alan'] = value;
                                  print(value);
                                  setState(() {});
                                },
                              ),
                              Radio(
                                groupValue: seletorLugar['alan'],
                                value: grupoAlan.terceiroLugar,
                                visualDensity: VisualDensity(
                                    horizontal: VisualDensity.maximumDensity),
                                onChanged: (value) {
                                  print(value);
                                  seletorLugar['alan'] = value;
                                  setState(() {});
                                },
                              ),
                              Radio(
                                groupValue: seletorLugar['alan'],
                                value: grupoAlan.quartoLugar,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Row(
                            children: [
                              FlatButton(
                                child: Text("submit"),
                                onPressed: () {
                                  // TODO
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text("submit"),
                                onPressed: () {
                                  // TODO
                                  Navigator.pop(context);
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
      ),
    );
  }
}
