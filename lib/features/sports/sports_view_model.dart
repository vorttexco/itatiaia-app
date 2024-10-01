import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class SportsViewModel extends State<Sports> {
  InAppWebViewController? inAppWebViewController;
  bool isLoading = false;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    loadView();
  }

  void navigateToInternalPage(String url) {
    NavigatorManager(context).to(CustomWebView.route,
        data: WebviewNavigatorModel(url: url, title: 'Blog'), onFinished: () {
      inAppWebViewController?.goBack();
    });
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
