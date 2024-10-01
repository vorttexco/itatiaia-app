import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// A wrapper for [YoutubePlayer].
class CustomYoutubePlayerBuilder extends StatefulWidget {
  /// Builder for [YoutubePlayer] that supports switching between fullscreen and normal mode.
  const CustomYoutubePlayerBuilder({
    super.key,
    required this.player,
    required this.builder,
    this.onEnterFullScreen,
    this.onExitFullScreen,
  });

  /// The actual [YoutubePlayer].
  final YoutubePlayer player;

  /// Builds the widget below this [builder].
  final Widget Function(BuildContext, Widget) builder;

  /// Callback to notify that the player has entered fullscreen.
  final VoidCallback? onEnterFullScreen;

  /// Callback to notify that the player has exited fullscreen.
  final VoidCallback? onExitFullScreen;

  @override
  State<CustomYoutubePlayerBuilder> createState() =>
      _CustomYoutubePlayerBuilderState();
}

class _CustomYoutubePlayerBuilderState extends State<CustomYoutubePlayerBuilder>
    with WidgetsBindingObserver {
  final GlobalKey playerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final physicalSize = PlatformDispatcher.instance.views.first.physicalSize;
    final controller = widget.player.controller;
    if (physicalSize.width > physicalSize.height) {
      controller.updateValue(controller.value.copyWith(isFullScreen: true));
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      widget.onEnterFullScreen?.call();
    } else {
      controller.updateValue(controller.value.copyWith(isFullScreen: false));
      SystemChrome.restoreSystemUIOverlays();
      widget.onExitFullScreen?.call();
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    final player = Container(
      key: playerKey,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          final controller = widget.player.controller;
          if (controller.value.isFullScreen) {
            widget.player.controller.toggleFullScreenMode();
          } else {
            if (!didPop) {
              Navigator.pop(context);
            }
          }
        },
        child: widget.player,
      ),
    );
    final child = widget.builder(context, player);

    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait ? child : player;
      },
    );
  }
}
