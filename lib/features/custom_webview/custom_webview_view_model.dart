// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/index.dart';
import './custom_webview.dart';

abstract class CustomWebviewViewModel extends State<CustomWebView> {
  final userRepository = UserRepository(ApiConnector());
  final controller = WebViewController();
  UserModel? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.enableZoom(false);
    controller.setNavigationDelegate(
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
        onWebResourceError: (WebResourceError error) {},
      ),
    );
    Logger.log(widget.navigatorModel.url);
    _loadView();
  }

  Future<void> _loadView() async {
    userModel = await userRepository.get(null);
    setState(() {});

    try {
      final url = '${widget.navigatorModel.url}?hidemenu=true';
      controller.loadRequest(Uri.parse(url));
    } on Exception catch (e) {
      Logger.log(e.toString());
    }
  }

  onBack() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return;
    }
    NavigatorManager(context).back();
  }
}
