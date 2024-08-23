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
    listOfMenu = await HomeRepository(ApiConnector()).menu();
    userModel = await userRepository.get(null);
    setState(() {});
  }

  openMenu(MenuHomeModel menu) {
    if (menu.items!.isEmpty) {
      NavigatorManager(context).to(CustomWebView.route,
          data: WebviewNavigatorModel(
              title: menu.label ?? '', url: menu.url ?? ''));
      return;
    }

    NavigatorManager(context)
        .to(Submenu.route, data: menu, rootNavigator: false);
  }
}
