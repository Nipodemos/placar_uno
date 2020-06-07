import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:placar_uno/models/jogatina_model.dart';

class JogatinaControllerGenerica extends GetController {
  static JogatinaControllerGenerica get to => Get.find();

  Box boxJogatinas = Hive.box('jogatinas');

  JogatinaModel getJogatinaModel({@required int index}) {
    return boxJogatinas.getAt(index);
  }
}
