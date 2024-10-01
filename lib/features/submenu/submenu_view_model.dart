import 'package:flutter/material.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class SubmenuViewModel extends State<Submenu> {
  openMenu(MenuHomeModel? menu) {
    if (menu!.items!.isEmpty) {
      NavigatorManager(context).to(CustomWebView.route,
          data: WebviewNavigatorModel(
              title: menu.label ?? '', url: '${menu.url}?hidemenu=true'));
      return;
    }

    NavigatorManager(context)
        .to(Submenu.route, data: menu, rootNavigator: false);
  }

  onBack() {
    Logger.log('onback');
    Navigator.of(context).pop();
  }
}
