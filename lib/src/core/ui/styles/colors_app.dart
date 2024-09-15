import 'package:flutter/widgets.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();
  static ColorsApp get i => _instance ??= ColorsApp._();

  Color get appBar => const Color(0XFF17192D);
  Color get primary => const Color(0XFF2188FF);
  Color get critical => const Color(0XFFED3833);
  Color get energy => const Color(0XFF52C41A);
}

extension ColorsAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.i;
}
