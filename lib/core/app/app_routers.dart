import 'package:flutter/material.dart';
import 'package:itatiaia_app/features/index.dart';
import 'package:itatiaia_app/features/youtube_full_screen/youtube_full_screen.dart';

import '../../../core/models/webview_navigator_model.dart';

class AppRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Splash());
      case TabNavigator.route:
        return MaterialPageRoute(builder: (_) => const TabNavigator());
      case Home.route:
        return MaterialPageRoute(builder: (_) => const Home());
      case Videos.route:
        return MaterialPageRoute(builder: (_) => const Videos());
      case Sports.route:
        return MaterialPageRoute(builder: (_) => const Sports());
      case Promotions.route:
        return MaterialPageRoute(builder: (_) => const Promotions());
      case Search.route:
        return MaterialPageRoute(builder: (_) => const Search());

      case CustomWebView.route:
        return MaterialPageRoute(
            builder: (_) => CustomWebView(
                  navigatorModel: settings.arguments as WebviewNavigatorModel,
                ));
      case YoutubeFullScreen.route:
        return MaterialPageRoute(
            builder: (_) => YoutubeFullScreen(
                  videoId: settings.arguments as String,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
