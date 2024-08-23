import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class PromotionsViewModel extends State<Promotions> {
  final webViewController = WebViewController();
  bool isLoading = false;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(const Color(0x00000000));
    webViewController.enableZoom(false);
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
    webViewController
        .loadRequest(Uri.parse('https://www.itatiaia.com.br/sorteio'));
    loadView();
  }

  void navigateToInternalPage(String url) {
    NavigatorManager(context).to(
      CustomWebView.route,
      data: WebviewNavigatorModel(url: url, title: 'Blog'),
    );
  }

  Future<void> loadView() async {
    userModel = await UserRepository(ApiConnector()).get(null);
    setState(() {});
  }

  void openMenu() {
    NavigatorManager(context)
        .fullModal(const HomeMenu(), fullscreenDialog: true);
  }
}
