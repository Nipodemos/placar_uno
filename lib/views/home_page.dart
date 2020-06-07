import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placar_uno/controllers/jogatina_controller.dart';
import 'package:placar_uno/models/jogatina_model.dart';

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
            if (JogatinaController.to.boxJogatinaAtual.get('indice') == null)
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
              ),
            Expanded(
              child: ListView.builder(
                itemCount: JogatinaController.to.boxJogatinas.length,
                itemBuilder: (_, i) {
                  JogatinaModel jogatina =
                      JogatinaController.to.boxJogatinas.getAt(i);
                  return Center(
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(
                          'descrever_jogatina',
                          arguments: i,
                        );
                      },
                      title: Text(
                        "Começou: ${jogatina.dataInicio}\nTerminou ${jogatina.dataFim ?? 'Não terminou'}",
                      ),
                      subtitle: Text(
                        "Completado: " + (jogatina.completado ? "Sim" : "Não"),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
