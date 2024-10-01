import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/components/custom_inapp_web_view.dart';
import 'package:provider/provider.dart';

import '../../core/index.dart';
import '../../core/providers/tab_bar_provider.dart';
import './home_view_model.dart';

class HomeView extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<TabbarProvider>(
        builder:
            (BuildContext context, TabbarProvider tabBarView, Widget? child) {
          if (tabBarView.reloadHome) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Provider.of<TabbarProvider>(context, listen: false)
                    .setReloadHome(false);

                onTapLogo();
              },
            );
          }
          return _buildBody();
        },
      ),
    );
  }

  Scaffold _buildBody() {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      body: Column(
        children: [
          MenuHorizontal(
            scrollController: scrollControllerMenu,
            items: listOfHomeMenu,
            onSelectedMenu: onMenuSelected,
            selectedIndex: selectedIndex,
          ),
          Expanded(
              child: CustomInAppWebViewComponent(
            onCreated: (controller) {
              webViewController = controller;
            },
            openExternalUrl: navigateToInternalPage,
            initialUrl: ApiHome.home,
          ))
        ],
      ),
    );
  }
}
