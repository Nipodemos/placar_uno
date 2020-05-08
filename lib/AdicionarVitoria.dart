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
                onPressed: () {
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
                    placarUnoBox.put('alan',
                        numberToKey[seletorLugar['alan']] ++);
                    placarUnoBox.put('guilherme',
                        numberToKey[seletorLugar['guilherme']] ++);
                    placarUnoBox.put('joao',
                        numberToKey[seletorLugar['joao']] ++);
                    placarUnoBox.put('tomas',
                        numberToKey[seletorLugar['tomas']] ++);
                    print('ao que tudo indica, deu certo');
                    //print(todosOsPlacares);
                    //message =
                    //    "Feito! parabens aos vencedores!";
                    setState(() {});
                  } else {
                    print('algum valor ta vazio');
                    //message = "algum valor ta vazio";
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
