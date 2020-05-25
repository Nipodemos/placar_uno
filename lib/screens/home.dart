import 'package:flutter/material.dart';
import 'package:placar_uno/screens/listar_jogadores.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placar Uno'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(),
              Text(
                'Placar Uno',
                style: TextStyle(fontSize: 28),
              ),
              RaisedButton(
                child: Text('Nova Jogatina'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListarJogadores()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
