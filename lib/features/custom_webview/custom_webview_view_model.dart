// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/index.dart';
import './custom_webview.dart';

abstract class CustomWebviewViewModel extends State<CustomWebView> {
  final userRepository = UserRepository(ApiConnector());
  InAppWebViewController? controller;
  UserModel? userModel;
  String currentUrl = '';

  @override
  void initState() {
    super.initState();
    currentUrl = widget.navigatorModel.url;
    _loadView();
  }

  Future<void> _loadView() async {
    userModel = await userRepository.get(null);
    setState(() {});
  }

  onBack() async {
    if (await controller?.canGoBack() ?? false) {
      controller?.goBack();
      return;
    }
    NavigatorManager(context).back();
  }

  onShare() async {
    final uri = await controller?.getUrl();
    currentUrl = uri.toString().replaceAll('?hidemenu=true', '');

    Share.share(currentUrl, subject: 'Itatiaia');
  }
}
