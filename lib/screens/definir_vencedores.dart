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
  List<Slide> slides = new List();
  num indexJogatinaAtual;
  Box boxJogatinas;
  Jogatina jogatina;

  @override
  void initState() {
    super.initState();

    indexJogatinaAtual = Hive.box('jogatinaAtual').get('indice') as num;
    boxJogatinas = Hive.box('jogatinas');
    jogatina = boxJogatinas.getAt(indexJogatinaAtual);

    jogatina.jogadores.forEach((element) {
      slides.add(
        Slide(
            title: element + " venceu em qual posição?",
            description: "Diz aí qual foi!",
            centerWidget: ListView.builder(
                itemCount: jogatina.jogadores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text((index + 1).toString() + "º lugar",),
                    leading: Radio(value: null, groupValue: null, onChanged: null),
                  );
                })),
      );
    });

    slides.add(
      new Slide(
        title: "ERASER",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "PENCIL",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
