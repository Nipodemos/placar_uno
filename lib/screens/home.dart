import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:placar_uno/screens/listar_jogadores.dart';

import 'jogatina_em_andamento.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box boxJogatinaAtual;
  int indexJogatinaAtual;

  @override
  void initState() {
    boxJogatinaAtual = Hive.box('jogatinaAtual');
    indexJogatinaAtual = boxJogatinaAtual.get('indice') as num;
    super.initState();
  }

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
              if (indexJogatinaAtual == null)
                RaisedButton(
                  child: Text('Nova Jogatina'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListarJogadores(),
                      ),
                    );
                  },
                )
              else
                RaisedButton(
                  child: Text('Continuar Jogatina'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JogatinaEmAndamento(),
                      ),
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
