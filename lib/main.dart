import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placar_uno/models/jogatina.dart';

import 'screens/definir_vencedores.dart';
import 'screens/home.dart';
import 'screens/jogatina_em_andamento.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(JogatinaAdapter());
  await Hive.openBox("jogatinas");
  await Hive.openBox("jogadores");
  await Hive.openBox("jogatinaAtual");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
