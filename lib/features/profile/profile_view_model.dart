import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class ProfileViewModel extends State<Profile>
    with WidgetsBindingObserver {
  UserModel? userModel;
  final userRepository = UserRepository(ApiConnector());
  bool hasPermission = false;
  List<MenuHomeModel> listOfMenu = [
    MenuHomeModel(
        label: 'Quem somos',
        url: 'https://www.itatiaia.com.br/quem-somos?hidemenu=true'),
    MenuHomeModel(
        label: 'Politica de Privacidade',
        url:
            'https://www.itatiaia.com.br/politica-de-privacidade?hidemenu=true'),
    MenuHomeModel(
        label: 'Portal de Cookies',
        url:
            'https://www.itatiaia.com.br/politica-de-cookies-e-tecnologias-similares?hidemenu=true'),
    MenuHomeModel(
        label: 'Contato',
        url: 'https://www.itatiaia.com.br/contato?hidemenu=true'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadView();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.resumed == state) {
      hasPermission = OneSignal.Notifications.permission;
      setState(() {});
    }
  }

  Future<void> loadView() async {
    try {
      userModel = await userRepository.get(null);
    } finally {
      setState(() {});
    }
  }

  openLink(MenuHomeModel menu) async {
    NavigatorManager(context).to(
      CustomWebView.route,
      data: WebviewNavigatorModel(
          url: '${menu.url}',
          title: menu.label ?? AppLabel.appName,
          showShare: false),
    );
  }

  void openMenu() {
    NavigatorManager(context)
        .fullModal(const HomeMenu(), fullscreenDialog: true);
  }

  Future<void> login() async {}
}
