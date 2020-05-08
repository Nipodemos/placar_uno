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
      body: Center(
          child: ListView(
        children: [
          ListTile(
            title: Text("Alan"),
            trailing: Text(
                todosOsPlacares['alan']['placarTotal'].toString() + " pontos"),
            subtitle: Text(
              "${getSingleScore(pessoa: 'alan',qualPlacar:'primeiroLugar')}\n"
              "${getSingleScore(pessoa: 'alan',qualPlacar:'segundoLugar')}\n"
              "${getSingleScore(pessoa: 'alan',qualPlacar:'terceiroLugar')}\n"
              "${getSingleScore(pessoa: 'alan',qualPlacar:'quartoLugar')}\n"
            ),
          ),
          ListTile(
            title: Text("Guilherme"),
            trailing: Text(
                todosOsPlacares['guilherme']['placarTotal'].toString() +
                    " pontos"),
            subtitle: Text(
              "${getSingleScore(pessoa: 'guilherme',qualPlacar:'primeiroLugar')}\n"
              "${getSingleScore(pessoa: 'guilherme',qualPlacar:'segundoLugar')}\n"
              "${getSingleScore(pessoa: 'guilherme',qualPlacar:'terceiroLugar')}\n"
              "${getSingleScore(pessoa: 'guilherme',qualPlacar:'quartoLugar')}\n"
            ),
          ),
          ListTile(
            title: Text("João"),
            trailing: Text(
                todosOsPlacares['joao']['placarTotal'].toString() + " pontos"),
            subtitle: Text(
              "${getSingleScore(pessoa: 'joao',qualPlacar:'primeiroLugar')}\n"
              "${getSingleScore(pessoa: 'joao',qualPlacar:'segundoLugar')}\n"
              "${getSingleScore(pessoa: 'joao',qualPlacar:'terceiroLugar')}\n"
              "${getSingleScore(pessoa: 'joao',qualPlacar:'quartoLugar')}\n"
            ),
          ),
          ListTile(
            title: Text("Tomás"),
            trailing: Text(
                todosOsPlacares['tomas']['placarTotal'].toString() + " pontos"),
            subtitle: Text(
              "${getSingleScore(pessoa: 'tomas',qualPlacar:'primeiroLugar')}\n"
              "${getSingleScore(pessoa: 'tomas',qualPlacar:'segundoLugar')}\n"
              "${getSingleScore(pessoa: 'tomas',qualPlacar:'terceiroLugar')}\n"
              "${getSingleScore(pessoa: 'tomas',qualPlacar:'quartoLugar')}\n"
              
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
