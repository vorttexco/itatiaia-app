import 'package:flutter/material.dart';

import '../index.dart';

class NavigatorManager {
  final BuildContext context;

  NavigatorManager(this.context);

  void to(String route,
      {dynamic data,
      Function? onFinished,
      fullscreen = false,
      bool rootNavigator = true}) {
    Navigator.of(context, rootNavigator: rootNavigator)
        .pushNamed(route, arguments: data)
        .then((value) {
      onFinished?.call();
    });
  }

  void fullModal(
    Widget widget, {
    dynamic data,
    Function? onFinished,
    fullscreenDialog = false,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
        settings: RouteSettings(arguments: data),
      ),
    ).then((value) {
      onFinished?.call();
    });
  }

  void replacement(String route, {dynamic data, VoidCallback? onFinished}) =>
      Navigator.of(context)
          .pushReplacementNamed(route, arguments: data)
          .then((value) {
        onFinished?.call();
      });

  void back() => Navigator.of(context).pop();

  void modal(
    Widget child, {
    dynamic data,
    Function? onFinished,
    enableDrag = true,
    Color backgroudColor = Colors.white,
  }) {
    showModalBottomSheet(
      enableDrag: enableDrag,
      context: context,
      backgroundColor: backgroudColor,
      isScrollControlled: true,
      constraints: BoxConstraints.tight(
        Size(
          MediaQuery.of(context).size.width,
          (MediaQuery.of(context).size.height -
              ((MediaQuery.of(context).size.height - 550) / 2)),
        ),
      ),
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroudColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Visibility(
                  visible: enableDrag,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.KPADDING_16),
                    child: Container(
                      width: 80,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30)),
                      ),
                    ),
                  ),
                ),
                child
              ],
            ),
          ),
        );
      },
    );
  }

  void modalVideo(Widget child) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.7),
      isScrollControlled: true,
      builder: (context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: child,
        ),
      ),
    );
  }
}
