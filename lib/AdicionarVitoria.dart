import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AdicionarVitoria extends StatefulWidget {
  @override
  _AdicionarVitoriaState createState() => _AdicionarVitoriaState();
}

class _AdicionarVitoriaState extends State<AdicionarVitoria> {
  Box<Map> placarUnoBox;

  @override
  void initState() {
    super.initState();
    placarUnoBox = Hive.box<Map>("placarUno");
  }

  //Map seletorLugar = {'alan': 0, 'guilherme': 0, 'joao': 0, 'tomas': 0};
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioPositionInScore(name: 'Alan', chave: 'alan'),
          SizedBox(height: 16),
          RadioPositionInScore(name: 'Guilherme', chave: 'guilherme'),
          SizedBox(height: 16),
          RadioPositionInScore(name: 'João', chave: 'joao'),
          SizedBox(height: 16),
          RadioPositionInScore(name: 'Tomás', chave: 'tomas'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {},
              ),
              Divider(),
              RaisedButton(
                child: Text("Confirmar"),
                onPressed: () {
                  Map seletorLugar =
                      placarUnoBox.get('valoresContainerDefinirPlacar');

                  print('seletorLugar inside confirmar button:');
                  print(seletorLugar);
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
                    var boxAlan = placarUnoBox.get('alan');
                    boxAlan[numberToKey[seletorLugar['alan']]]++;
                    boxAlan['placarTotal'] = (boxAlan['primeiroLugar'] * 4) +
                        (boxAlan['segundoLugar'] * 3) +
                        (boxAlan['terceiroLugar'] * 2) +
                        (boxAlan['quartoLugar'] * 1);

                    var boxGuilherme = placarUnoBox.get('guilherme');
                    boxGuilherme[numberToKey[seletorLugar['guilherme']]]++;
                    boxGuilherme['placarTotal'] =
                        (boxGuilherme['primeiroLugar'] * 4) +
                            (boxGuilherme['segundoLugar'] * 3) +
                            (boxGuilherme['terceiroLugar'] * 2) +
                            (boxGuilherme['quartoLugar'] * 1);

                    var boxJoao = placarUnoBox.get('joao');
                    boxJoao[numberToKey[seletorLugar['joao']]]++;
                    boxJoao['placarTotal'] = (boxJoao['primeiroLugar'] * 4) +
                        (boxJoao['segundoLugar'] * 3) +
                        (boxJoao['terceiroLugar'] * 2) +
                        (boxJoao['quartoLugar'] * 1);

                    var boxTomas = placarUnoBox.get('tomas');
                    boxTomas[numberToKey[seletorLugar['tomas']]]++;
                    boxTomas['placarTotal'] = (boxTomas['primeiroLugar'] * 4) +
                        (boxTomas['segundoLugar'] * 3) +
                        (boxTomas['terceiroLugar'] * 2) +
                        (boxTomas['quartoLugar'] * 1);

                    placarUnoBox.put('alan', boxAlan);
                    placarUnoBox.put('guilherme', boxGuilherme);
                    placarUnoBox.put('joao', boxJoao);
                    placarUnoBox.put('tomas', boxTomas);

                    placarUnoBox.put(
                      'valoresContainerDefinirPlacar',
                      {'alan': 0, 'guilherme': 0, 'joao': 0, 'tomas': 0},
                    );

                    print('ao que tudo indica, deu certo');
                    final snackBar = SnackBar(content: Text('Adicionado com sucesso!'));
                    Scaffold.of(context).showSnackBar(snackBar);
                    setState(() {});
                  } else {
                    final snackBar = SnackBar(content: Text('Ocorreu um erro...'));
                    Scaffold.of(context).showSnackBar(snackBar);
                    print('algum valor ta vazio');
                    setState(() {});
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RadioPositionInScore extends StatefulWidget {
  final String name;
  final String chave;
  RadioPositionInScore({this.name, this.chave});

  @override
  _RadioPositionInScoreState createState() => _RadioPositionInScoreState();
}

class _RadioPositionInScoreState extends State<RadioPositionInScore> {
  Box<Map> placarUnoBox;
  @override
  void initState() {
    super.initState();
    placarUnoBox = Hive.box<Map>("placarUno");
    if (placarUnoBox.get('valoresContainerDefinirPlacar') == null) {
      placarUnoBox.put(
        'valoresContainerDefinirPlacar',
        {'alan': 0, 'guilherme': 0, 'joao': 0, 'tomas': 0},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(widget.name),
            width: 80,
          ),
          radioButtonDaPosicao(1),
          radioButtonDaPosicao(2),
          radioButtonDaPosicao(3),
          radioButtonDaPosicao(4)
        ],
      ),
    );
  }

  Widget radioButtonDaPosicao(int valor) {
    Map seletorLugar = placarUnoBox.get('valoresContainerDefinirPlacar');
    return Radio<int>(
      groupValue: seletorLugar[widget.chave],
      value: valor,
      onChanged: (value) {
        setState(() {
          print(value);
          seletorLugar[widget.chave] = value;
        });
      },
    );
  }
}
