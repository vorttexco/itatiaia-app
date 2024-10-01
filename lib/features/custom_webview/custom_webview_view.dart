import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/components/app_bar_webview.dart';
import 'package:itatiaia_app/core/components/custom_inapp_web_view.dart';

import './custom_webview_view_model.dart';

class CustomWebviewView extends CustomWebviewViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            AppBarwebView(
              title: 'Voltar',
              onIconPressed: onBack,
              onShare: widget.navigatorModel.showShare ? onShare : null,
            ),
            Expanded(
              child: CustomInAppWebViewComponent(
                onCreated: (controllerOrigin) {
                  controller = controllerOrigin;
                },
                initialUrl: widget.navigatorModel.url,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
