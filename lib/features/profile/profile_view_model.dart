import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class ProfileViewModel extends State<Profile>
    with WidgetsBindingObserver {
  UserModel? userModel;
  final userRepository = UserRepository(ApiConnector());
  bool hasPermission = false;
  List<MenuHomeModel> listOfMenu = [];

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
      hasPermission = OneSignal.Notifications.permission;
      listOfMenu = await HomeRepository(ApiConnector()).menu();
      // if (userModel != null) {
      //   // listOfMenu.add(
      //   //   MenuHomeModel(label: 'Logout', id: AppConstants.MENU_LOGOUT_ID),
      //   // );
      // }
    } finally {
      setState(() {});
    }
  }

  void onTapPermissionRequest(bool value) {
    if (!OneSignal.Notifications.permission) {
      OneSignal.Notifications.requestPermission(value);
      hasPermission = OneSignal.Notifications.permission;
      setState(() {});
    }
  }

  openLink(MenuHomeModel menu) async {
    NavigatorManager(context).to(
      CustomWebView.route,
      data: WebviewNavigatorModel(
          url: '${menu.url}?hidemenu=true',
          title: menu.label ?? AppLabel.appName),
    );
  }

  void openMenu() {
    NavigatorManager(context)
        .fullModal(const HomeMenu(), fullscreenDialog: true);
  }

  Future<void> login() async {}
}
