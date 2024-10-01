import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class PromotionsViewModel extends State<Promotions> {
  InAppWebViewController? inAppWebViewController;

  UserModel? userModel;

  bool clicked = false;
  bool isLoading = false;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    loadView();
  }

  void navigateToInternalPage(String url) {
    NavigatorManager(context).to(CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Loja'), onFinished: () {
      inAppWebViewController?.goBack();
    });
  }

  Future<void> loadView() async {
    userModel = await UserRepository(ApiConnector()).get(null);
    setState(() {});
  }

  void openMenu() {
    NavigatorManager(context).fullModal(
      const HomeMenu(),
      fullscreenDialog: true,
    );
  }
}
