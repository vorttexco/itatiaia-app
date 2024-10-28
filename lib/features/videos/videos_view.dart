import 'package:flutter/material.dart';
import 'package:itatiaia_app/features/videos/components/list_video_view.dart';
import 'package:itatiaia_app/features/videos/components/video_menu_horizontal.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/index.dart';
import '../../core/providers/tab_bar_provider.dart';
import './videos_view_model.dart';

class VideosView extends VideosViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: YoutubePlayerBuilder(
        onExitFullScreen: () {
          Provider.of<TabbarProvider>(context, listen: false)
              .setVideoFullScreen(false);
        },
        onEnterFullScreen: () {
          Provider.of<TabbarProvider>(context, listen: false)
              .setVideoFullScreen(true);
        },
        player: YoutubePlayer(controller: youtubePlayerController),
        builder: (context, player) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VideoMenuHorizontal(
                  scrollController: scrollController,
                  items: itemsOfMenu,
                  onSelectedMenu: onMenuSelected,
                  selectedItem: menuSelected,
                ),
                Visibility(
                  visible: menuSelected?.id == 0 && videoLiveModel != null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: player,
                  ),
                ),
                Visibility(
                  visible: menuSelected?.id == 0 && videoLiveModel != null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomText(
                      (videoLiveModel != null &&
                              videoLiveModel!.items!.isNotEmpty)
                          ? (videoLiveModel?.items?.first.snippet?.title ?? '')
                          : '',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Visibility(
                  visible: videoModel == null,
                  child: const Expanded(
                    child: Center(
                      child: CustomText(
                        'Não foi possível mostrar os videos nesse momento.',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: menuSelected?.id != 0 && videoModel != null,
                  child: Expanded(
                    child: ListVideoView(
                      model: videoModel,
                      onSelectedItem: onSelectedItem,
                      scrollController: scrollController,
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
