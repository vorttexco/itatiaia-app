// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/index.dart';
import '../index.dart';

abstract class SplashViewModel extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));

    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        AppConstants.screenWidth = MediaQuery.of(context).size.width;
        AppConstants.screenHeight = MediaQuery.of(context).size.height;
        NavigatorManager(context).replacement(TabNavigator.route);
      },
    );
  }
}
