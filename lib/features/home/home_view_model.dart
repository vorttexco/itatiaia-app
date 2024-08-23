// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class HomeViewModel extends State<Home> with WidgetsBindingObserver {
  List<MenuHomeModel> listOfHomeMenu = [];
  UserModel? userModel;
  bool isLoading = true;
  bool isFromMenu = true;
  int selectedIndex = 0;

  final scrollControllerMenu = ScrollController();
  final webViewController = WebViewController();
  final userRepository = UserRepository(ApiConnector());
  final webCookieManager = WebViewCookieManager();

  final homeRepository = HomeRepository(ApiConnector());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    webCookieManager.setCookie(const WebViewCookie(
      name: "cookie_consent",
      value: "true",
      domain: ".tatiaia.com.br",
      path: "/",
    ));

    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(const Color(0x00000000));
    webViewController.enableZoom(false);

    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
          if (!isFromMenu) {
            Logger.log('onPageStarted"$url');
            navigateToInternalPage(url);
            return;
          }
          isFromMenu = false;
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
        onWebResourceError: (error) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );

    webViewController.loadRequest(Uri.parse(ApiHome.home));
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
    NavigatorManager(context).to(
      CustomWebView.route,
      data: WebviewNavigatorModel(url: url, title: 'Home'),
    );
  }

  void onMenuSelected(MenuHomeModel menu, int index) {
    isFromMenu = true;
    setState(() {
      selectedIndex = index;
    });
    webViewController.loadRequest(Uri.parse('${menu.url}?hidemenu=true'));
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
    isFromMenu = true;
    scrollControllerMenu.animateTo(0,
        duration: Durations.short2, curve: Curves.linear);

    setState(() {
      selectedIndex = 0;
    });

    try {
      webViewController.loadRequest(Uri.parse(ApiHome.home));
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {}
  }
}
