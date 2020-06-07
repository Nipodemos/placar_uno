import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placar Uno'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(),
            Text(
              'Placar Uno',
              style: TextStyle(fontSize: 28),
            ),
            if (JogatinaController.to.indexJogatinaAtual == null)
              RaisedButton(
                child: Text('Nova Jogatina'),
                onPressed: () {
                  Get.offNamed('selecionar_jogadores');
                },
              )
            else
              RaisedButton(
                child: Text('Continuar Jogatina'),
                onPressed: () {
                  Get.offNamed('jogatina_em_andamento');
                },
              )
          ],
        ),
      ),
    );
  }
}
