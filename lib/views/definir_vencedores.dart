import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';
import 'package:placar_uno/models/jogatina_model.dart';

Map<String, int> vencedores = {};

class DefinirVencedores extends StatelessWidget {
  List<Slide> getSlides() {
    return JogatinaController.to.jogatinaModel.jogadores.map((jogador) {
      return Slide(
        title: jogador + " venceu em qual posição?",
        maxLineTitle: 2,
        backgroundColor: Color(0xfff5a623),
        centerWidget: VenceuEmQualPosicao(jogador),
      );
    }).toList();
  }

  void onDonePress() {
    JogatinaController.to.jogatinaModel.resultadoPartidas.add(vencedores);
    JogatinaController.to.updateJogatinaAtual();
    vencedores = {};
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (JogatinaController.to.indexJogatinaAtual == null) {
      return Center(
        child: Text('treta'),
      );
    } else {
      return IntroSlider(
        slides: getSlides(),
        onDonePress: onDonePress,
        isShowSkipBtn: false,
        isShowPrevBtn: true,
        isScrollable: true,
      );
    }
  }
}

class VenceuEmQualPosicao extends StatefulWidget {
  final String jogador;
  VenceuEmQualPosicao(this.jogador);
  @override
  _VenceuEmQualPosicaoState createState() => _VenceuEmQualPosicaoState();
}

class _VenceuEmQualPosicaoState extends State<VenceuEmQualPosicao> {
  int indexJogatinaAtual;
  Box boxJogatinas;
  JogatinaModel jogatina;
  @override
  void initState() {
    Box boxIndexJogatina = Hive.box('jogatinaAtual');
    indexJogatinaAtual = boxIndexJogatina.get('indice');
    boxJogatinas = Hive.box('jogatinas');
    jogatina = boxJogatinas.getAt(indexJogatinaAtual);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: jogatina.jogadores.map((element) {
        int index = jogatina.jogadores.indexOf(element);
        return GestureDetector(
          onTap: () {
            setState(() {
              print('toque detectado');
              vencedores[widget.jogador] = index + 1;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: index + 1,
                groupValue: vencedores[widget.jogador],
                onChanged: (int newValue) {
                  setState(() {
                    vencedores[widget.jogador] = newValue;
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
    );
  }
}
