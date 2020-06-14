import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placar_uno/bindings/jogadores_binding.dart';
import 'package:placar_uno/bindings/jogatina_binding.dart';
import 'package:placar_uno/views/descrever_jogatina.dart';
import 'package:placar_uno/views/listar_partidas.dart';

import 'models/jogatina_model.dart';

import 'views/jogatina_acabou.dart';
import 'views/selecionar_jogadores.dart';
import 'views/jogatina_em_andamento.dart';
import 'views/definir_vencedores.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(JogatinaModelAdapter());
  await Hive.openBox("jogatinas");
  await Hive.openBox<String>("jogadores");
  await Hive.openBox("jogatinaAtual");
  runApp(
    GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      initialBinding: JogatinaBinding(),
      namedRoutes: {
        '/': GetRoute(
          page: HomePage(),
        ),
        'descrever_jogatina': GetRoute(
          page: DescreverJogatinas(),
        ),
        '/selecionar_jogadores': GetRoute(
          page: ListarJogadores(),
          binding: JogadoresBinding(),
        ),
        '/jogatina_em_andamento': GetRoute(
          page: JogatinaEmAndamento(),
        ),
        'listar_partidas': GetRoute(
          page: ListarPartidas(),
        ),
        ),
        '/definir_vencedores': GetRoute(
          page: DefinirVencedores(),
        ),
        '/jogatina_acabou': GetRoute(
          page: JogatinaAcabou(),
        ),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
