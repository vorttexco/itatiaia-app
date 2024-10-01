import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../index.dart';

class CustomInAppWebViewComponent extends StatefulWidget {
  final GlobalKey? globalKey;
  final String initialUrl;
  final Function(String url)? openExternalUrl;

  final Function(InAppWebViewController controller) onCreated;

  const CustomInAppWebViewComponent({
    super.key,
    this.globalKey,
    this.openExternalUrl,
    required this.initialUrl,
    required this.onCreated,
  });

  @override
  State<CustomInAppWebViewComponent> createState() =>
      _CustomInAppWebViewComponentState();
}

class _CustomInAppWebViewComponentState
    extends State<CustomInAppWebViewComponent> {
  bool clicked = false;
  bool isLoading = false;
  double progress = 0;

  InAppWebViewSettings settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: true,
    allowsInlineMediaPlayback: true,
    clearCache: true,
    javaScriptEnabled: true,
    disableDefaultErrorPage: false,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
          onWebViewCreated: widget.onCreated,
          initialSettings: settings,
          onLoadStop: (controller, url) async {
            await controller.evaluateJavascript(source: '''
              document.addEventListener('click', function(event) {
                window.flutter_inappwebview.callHandler('elementClicked', 'clicked',);
              });
            ''');
          },
          onLoadStart: (controller, url) async {
            Logger.log(url.toString());
            if (url != null && !url.authority.contains('.itatiaia.com.br')) {
              if (clicked) {
                clicked = false;
              }
              progress = 10;
              InAppBrowser.openWithSystemBrowser(
                  url: WebUri('${url.toString()}?hidemenu=true'));
              Future.delayed(const Duration(seconds: 1)).then(
                (value) {
                  controller.goBack();
                },
              );

              return;
            }

            if (clicked) {
              widget.openExternalUrl?.call(url.toString());
              clicked = false;
              return;
            }
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var url = navigationAction.request.url;
            if (url != null && url.authority.contains('.itatiaia.com.br')) {
              Uri uri = Uri.parse(url.toString());
              if (uri.queryParameters.containsKey('hidemenu')) {
                return NavigationActionPolicy.ALLOW;
              } else {
                String modifiedUrl;
                if (uri.query.isEmpty) {
                  modifiedUrl = "${uri.toString()}?hidemenu=true";
                } else {
                  modifiedUrl = "${uri.toString()}&hidemenu=true";
                }
                controller.loadUrl(
                    urlRequest: URLRequest(url: WebUri(modifiedUrl)));
                Logger.log(url.toString());
                return NavigationActionPolicy.CANCEL;
              }
            }
            Logger.log(url.toString());
            return NavigationActionPolicy.ALLOW;
          },
          onReceivedHttpError: (controller, request, errorResponse) {},
          onLoadResource: (controller, url) {
            controller.addJavaScriptHandler(
                handlerName: 'elementClicked',
                callback: (args) {
                  clicked = true;
                });
          },
          onProgressChanged: (controller, progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
        progress < 0.7
            ? Container(
                color: Colors.white.withOpacity(0.9),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
