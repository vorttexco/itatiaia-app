import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../main.dart';
import './youtube_full_screen.dart';

abstract class YoutubeFullScreenViewModel extends State<YoutubeFullScreen> {
  late YoutubePlayerController youtubePlayerController;

  @override
  void dispose() {
    super.dispose();
    youtubePlayerController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp
    ]);

    youtubePlayerController = YoutubePlayerController(
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        showLiveFullscreenButton: true,
        controlsVisibleAtStart: true,
      ),
      initialVideoId: widget.videoId,
    );
    youtubePlayerController.addListener(
      () async {
        if (youtubePlayerController.value.playerState == PlayerState.playing) {
          if (audioPlayerHandler.isPlaying()) {
            await audioPlayerHandler.stop();
          }
        }
      },
    );
  }
}
