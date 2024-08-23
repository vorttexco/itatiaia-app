import 'package:flutter/material.dart';

import '../../core/index.dart';
import './custom_webview_view_model.dart';

class CustomWebviewView extends CustomWebviewViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            AppBarInternal(
              titleWidget: CustomText(
                widget.navigatorModel.title,
                fontSize: AppConstants.KFONTSIZE_18,
                fontWeight: FontWeight.w700,
                textColor: Colors.black,
                textAlign: TextAlign.center,
              ),
              onIconPressed: onBack,
            ),
            Expanded(
              child: CustomWebViewComponent(
                webViewController: controller,
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
