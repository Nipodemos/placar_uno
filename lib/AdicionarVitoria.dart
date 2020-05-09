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

  Map seletorLugar = {'alan': 0, 'guilherme': 0, 'joao': 0, 'tomas': 0};
  @override
  Widget build(BuildContext context) {
    Map<String, int> teste = RadioPositionInScore().seletorLugar;
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    var tempAlan = placarUnoBox.get('alan');
                    tempAlan[numberToKey[seletorLugar['alan']]]++;
                    tempAlan['placarTotal'] = (tempAlan['primeiroLugar'] * 4) +
                        (tempAlan['segundoLugar'] * 3) +
                        (tempAlan['terceiroLugar'] * 2) +
                        (tempAlan['quartoLugar'] * 1);

                    var tempguilherme = placarUnoBox.get('guilherme');
                    tempguilherme[numberToKey[seletorLugar['guilherme']]]++;
                    tempguilherme['placarTotal'] =
                        (tempguilherme['primeiroLugar'] * 4) +
                            (tempguilherme['segundoLugar'] * 3) +
                            (tempguilherme['terceiroLugar'] * 2) +
                            (tempguilherme['quartoLugar'] * 1);

                    var tempjoao = placarUnoBox.get('joao');
                    tempjoao[numberToKey[seletorLugar['joao']]]++;
                    tempjoao['placarTotal'] = (tempjoao['primeiroLugar'] * 4) +
                        (tempjoao['segundoLugar'] * 3) +
                        (tempjoao['terceiroLugar'] * 2) +
                        (tempjoao['quartoLugar'] * 1);

                    var temptomas = placarUnoBox.get('tomas');
                    temptomas[numberToKey[seletorLugar['tomas']]]++;
                    temptomas['placarTotal'] =
                        (temptomas['primeiroLugar'] * 4) +
                            (temptomas['segundoLugar'] * 3) +
                            (temptomas['terceiroLugar'] * 2) +
                            (temptomas['quartoLugar'] * 1);

                    placarUnoBox.put('alan', tempAlan);
                    placarUnoBox.put('guilherme', tempguilherme);
                    placarUnoBox.put('joao', tempjoao);
                    placarUnoBox.put('tomas', temptomas);
                    print('ao que tudo indica, deu certo');
                    setState(() {});
                  } else {
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
  Map<String, int> seletorLugar = {
    'alan': 0,
    'guilherme': 0,
    'joao': 0,
    'tomas': 0
  };
  RadioPositionInScore({this.name, this.chave});

  @override
  _RadioPositionInScoreState createState() => _RadioPositionInScoreState();
}

class _RadioPositionInScoreState extends State<RadioPositionInScore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.name),
          radioButtonDaPosicao(1),
          radioButtonDaPosicao(2),
          radioButtonDaPosicao(3),
          radioButtonDaPosicao(4)
        ],
      ),
    );
  }

  Widget radioButtonDaPosicao(int valor) {
    return Radio(
      groupValue: widget.seletorLugar[widget.chave],
      value: valor,
      onChanged: (value) {
        setState(() {
          print(value);
          widget.seletorLugar[widget.chave] = value;
        });
      },
    );
  }
}
