import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/providers/tab_bar_provider.dart';
import 'package:provider/provider.dart';

import '../../core/components/custom_inapp_web_view.dart';
import './promotions_view_model.dart';

class PromotionsView extends PromotionsViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<TabbarProvider>(
        builder:
            (BuildContext context, TabbarProvider tabBarView, Widget? child) {
          if (tabBarView.reloadStore) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Provider.of<TabbarProvider>(context, listen: false)
                    .setReloadStore(false);
                inAppWebViewController?.goBack();
              },
            );
          }
          return Scaffold(
            body: CustomInAppWebViewComponent(
              initialUrl: 'https://shopping.itatiaia.com.br/?hidemenu=true',
              onCreated: (controller) {
                inAppWebViewController = controller;
              },
              openExternalUrl: navigateToInternalPage,
            ),
          );
        },
      ),
    );
  }
}
