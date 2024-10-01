import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/index.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import './youtube_full_screen_view_model.dart';

class YoutubeFullScreenView extends YoutubeFullScreenViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: youtubePlayerController,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          onReady: () {
            Logger.log('Player is ready.');
          },
          onEnded: (data) {
            Navigator.pop(context);
          },
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: Colors.black87,
            body: Stack(
              children: [
                Center(child: player),
                Positioned(
                  right: 16,
                  top: 60,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
