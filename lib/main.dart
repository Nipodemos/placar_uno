import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/jogatina.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(JogatinaAdapter());
  await Hive.openBox("jogatinas");
  await Hive.openBox("jogadores");
  await Hive.openBox("jogatinaAtual");
  runApp(HomePage());
}
