import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'adicionar_vitoria.dart';

class ListaDeJogadores extends StatefulWidget {
  @override
  _ListaDeJogadoresState createState() => _ListaDeJogadoresState();
}

class _ListaDeJogadoresState extends State<ListaDeJogadores> {
  bool mostrarTelaAddPlacar = false;
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

  String getSingleScore({String pessoa, String qualPlacar}) {
    //print('func getSingleScore, pessoa: $pessoa, qualPlacar: $qualPlacar');
    int contagemVitorias = placarUnoBox.get(pessoa)[qualPlacar];
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
      if (contagemVitorias == 0 || contagemVitorias == 1) {
        return "$contagemVitorias vitória   no ${keyToString[qualPlacar]} lugar\n";
      } else if (contagemVitorias > 1) {
        return "$contagemVitorias vitórias no ${keyToString[qualPlacar]} lugar\n";
      } else {
        return "Erro não esperado";
      }
    }
  }

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
              RaisedButton(
                child: Text(mostrarTelaAddPlacar
                    ? "Fechar tela placar"
                    : "Abrir tela placar"),
                onPressed: () {
                  mostrarTelaAddPlacar = !mostrarTelaAddPlacar;
                  setState(() {});
                },
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                height: mostrarTelaAddPlacar ? 320 : 0,
                child: mostrarTelaAddPlacar ? AdicionarVitoria() : Text(''),
              ),
              Divider(
                color: Colors.orange,
                thickness: 2,
              ),
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
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      List keysInList = placarUnoBox.keys.toList();
                      //print(index);
                      //print(keysInList);
                      //print(keysInList[index]);
                      var key = keysInList[index];
                      int placarTotal = placarUnoBox.get(key)['placarTotal'];
                      return ListTile(
                        title: Text(keysInList[index]),
                        trailing: Text(placarTotal.toString() +
                            (placarTotal > 1 ? " pontos" : ' ponto')),
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
              Divider(
                color: Colors.orange,
                thickness: 2,
              ),
              SizedBox(height: 60),
              RaisedButton(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
