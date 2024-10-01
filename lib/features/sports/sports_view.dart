import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/components/custom_inapp_web_view.dart';

import './sports_view_model.dart';

class SportsView extends SportsViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: CustomInAppWebViewComponent(
          onCreated: (controller) {
            inAppWebViewController = controller;
          },
          initialUrl: 'https://www.itatiaia.com.br/esportes/?hidemenu=true',
          openExternalUrl: navigateToInternalPage,
        ),
      ),
    );
  }
}
