import 'package:flutter/material.dart';
import 'package:itatiaia_app/features/index.dart';

import '../../core/index.dart';

abstract class HomeMenuViewModel extends State<HomeMenu> {
  final userRepository = UserRepository(ApiConnector());
  List<MenuHomeModel> listOfMenu = [];
  UserModel? userModel;

  @override
  void initState() {
    super.initState();

    loadView();
  }

  Future<void> loadView() async {
    final list = await HomeRepository(ApiConnector()).menu();

    for (var element in list) {
      if (element.label != null) {
        List<MenuHomeModel> internal = [];
        if (element.items != null && element.items!.isNotEmpty) {
          for (var item in element.items!) {
            if (item.label != null) {
              internal.add(item);
            }
          }
        }
        element.items = internal;

        listOfMenu.add(element);
      }
    }

    userModel = await userRepository.get(null);
    setState(() {});
  }

  openMenu(MenuHomeModel menu) {
    if (menu.items!.isEmpty) {
      NavigatorManager(context).to(
        CustomWebView.route,
        data: WebviewNavigatorModel(
          title: menu.label ?? '',
          url: '${menu.url}?hidemenu=true',
        ),
      );
      return;
    }

    NavigatorManager(context)
        .to(Submenu.route, data: menu, rootNavigator: false);
  }
}
