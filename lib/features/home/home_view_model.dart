// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class HomeViewModel extends State<Home> with WidgetsBindingObserver {
  List<MenuHomeModel> listOfHomeMenu = [];
  UserModel? userModel;

  int selectedIndex = 0;

  final scrollControllerMenu = ScrollController();

  final userRepository = UserRepository(ApiConnector());

  InAppWebViewController? webViewController;

  final homeRepository = HomeRepository(ApiConnector());

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
      reloadView();
    }
  }

  Future<void> loadView() async {
    try {
      listOfHomeMenu = await HomeRepository(ApiConnector()).menu();

      userModel = await userRepository.get(null);
    } finally {
      setState(() {});
    }
  }

  Future<void> reloadView() async {
    try {
      listOfHomeMenu = await HomeRepository(ApiConnector()).menu();
    } finally {
      setState(() {});
    }
  }

  void navigateToInternalPage(String url) {
    NavigatorManager(context).to(CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Home'), onFinished: () {
      webViewController?.goBack();
    });
  }

  void onMenuSelected(MenuHomeModel menu, int index) {
    setState(() {
      selectedIndex = index;
    });
    webViewController?.loadUrl(
      urlRequest: URLRequest(url: WebUri('${menu.url}?hidemenu=true')),
    );
  }

  Future<void> login() async {
    NavigatorManager(context)
        .fullModal(const Profile(), fullscreenDialog: true);
  }

  void openMenu() {
    NavigatorManager(context)
        .fullModal(const HomeMenu(), fullscreenDialog: true);
  }

  void openProfile() {
    NavigatorManager(context)
        .fullModal(const Profile(), fullscreenDialog: true);
  }

  onTapLogo() {
    scrollControllerMenu.animateTo(0,
        duration: Durations.short2, curve: Curves.linear);

    setState(() {
      selectedIndex = 0;
    });

    try {
      webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(ApiHome.home)),
      );
    } finally {}
  }
}
