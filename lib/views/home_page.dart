import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JogatinaController>(() => JogatinaController());
  }
}

class HomePage extends StatelessWidget {
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
              GetBuilder<JogatinaController>(
                builder: (controller) {
                  int indexJogatinaAtual = controller.indexJogatinaAtual;

                  if (indexJogatinaAtual == null) {
                    return RaisedButton(
                      child: Text('Nova Jogatina'),
                      onPressed: () {
                        Get.toNamed('selecionar_jogadores');
                      },
                    );
                  } else {
                    return RaisedButton(
                      child: Text('Continuar Jogatina'),
                      onPressed: () {
                        Get.toNamed('jogatina_em_andamento');
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
