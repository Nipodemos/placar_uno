import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:placar_uno/models/jogatina.dart';

class DefinirVencedores extends StatefulWidget {
  @override
  _DefinirVencedoresState createState() => _DefinirVencedoresState();
}

class _DefinirVencedoresState extends State<DefinirVencedores> {
  List<Slide> slides = [];
  int indexJogatinaAtual;
  Box boxJogatinas;
  Jogatina jogatina;
  Map<String, int> vencedores = {};

  @override
  void initState() {
    Box boxIndexJogatina = Hive.box('jogatinaAtual');
    indexJogatinaAtual = boxIndexJogatina.get('indice');
    boxJogatinas = Hive.box('jogatinas');
    jogatina = boxJogatinas.getAt(indexJogatinaAtual);

    jogatina.jogadores.forEach((jogador) {
      vencedores.addAll({jogador: 0});
      slides.add(
        Slide(
          title: jogador + " venceu em qual posição?",
          maxLineTitle: 2,
          backgroundColor: Color(0xfff5a623),
          centerWidget: Column(
            children: jogatina.jogadores.map((element) {
              int index = jogatina.jogadores.indexOf(element);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    print('toque detectado');
                    vencedores[jogador] = index + 1;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: index + 1,
                      groupValue: vencedores[jogador],
                      onChanged: (int newValue) {
                        setState(() {
                          vencedores[jogador] = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      (index + 1).toString() + "º lugar",
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
    super.initState();
  }

  void onDonePress() {
    // Do what you want
  }

  @override
  Widget build(BuildContext context) {
    if (indexJogatinaAtual == null) {
      return Center(
        child: Text('treta'),
      );
    } else {
      return IntroSlider(
        slides: slides,
        onDonePress: onDonePress,
        isShowSkipBtn: false,
        isShowPrevBtn: true,
        isScrollable: true,
      );
    }
  }
}
