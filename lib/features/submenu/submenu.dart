import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/index.dart';

import './submenu_view.dart';

class Submenu extends StatefulWidget {
  static const route = '/Submenu/';
  final MenuHomeModel model;
  const Submenu({super.key, required this.model});

  @override
  SubmenuView createState() => SubmenuView();
}
