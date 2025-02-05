// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itatiaia_app/features/notifications_settings/notifications_settings.dart';

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

    _checkAndStart();

    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        AppConstants.screenWidth = MediaQuery.of(context).size.width;
        AppConstants.screenHeight = MediaQuery.of(context).size.height;
        //NavigatorManager(context).replacement(TabNavigator.route);
      },
    );
  }

  _checkAndStart() async {
    var viewNotificationValue = await StorageManager()
        .getBool(AppConstants.SHARED_PREFERENCES_VIEW_NOTIFICATIONS_SETTINGS);

    await Future.delayed(const Duration(seconds: 3));

    if (viewNotificationValue == null) {
      await Navigator.pushNamed(context, NotificationsSettings.route);

      await StorageManager().setBool(
        AppConstants.SHARED_PREFERENCES_VIEW_NOTIFICATIONS_SETTINGS,
        true,
      );
    }

    NavigatorManager(context).replacement(TabNavigator.route);
  }
}
