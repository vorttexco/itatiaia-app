// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/repositories/video_repository.dart';
import 'package:itatiaia_app/features/youtube_full_screen/youtube_full_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/index.dart';
import '../../main.dart';
import '../index.dart';
import 'models/video_menu_model.dart';

abstract class VideosViewModel extends State<Videos> {
  final repository = VideoRepository(ApiConnector());

  ScrollController scrollController = ScrollController();
  VideoLiveModel? videoModel;
  VideoLiveModel? videoLiveModel;

  List<VideoMenuModel> itemsOfMenu = VideoMenuModel.list;
  VideoMenuModel? menuSelected;

  YoutubePlayerController youtubePlayerController =
      YoutubePlayerController(initialVideoId: '');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadView();
    });
  }

  @override
  void dispose() {
    super.dispose();
    youtubePlayerController.dispose();
  }

  loadView() async {
    loadLive();
  }

  loadLive() async {
    context.loaderOverlay.show();
    try {
      itemsOfMenu = VideoMenuModel.list;
      videoLiveModel = await repository.live();
      if (videoLiveModel == null && videoLiveModel?.items == null) {
        if (itemsOfMenu.length == 5) {
          itemsOfMenu.removeAt(0);
        }
      } else {
        youtubePlayerController = YoutubePlayerController(
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            showLiveFullscreenButton: true,
            controlsVisibleAtStart: true,
          ),
          initialVideoId: videoLiveModel?.items?.first.id?.videoId ?? '',
        );
        youtubePlayerController.addListener(
          () async {
            if (youtubePlayerController.value.playerState ==
                PlayerState.playing) {
              if (audioPlayerHandler.isPlaying()) {
                await audioPlayerHandler.stop();
              }
            }
          },
        );
      }

      menuSelected = itemsOfMenu.first;
      loadVideo();
    } catch (e) {
      if (itemsOfMenu.length == 5) {
        itemsOfMenu.removeAt(0);
      }
      menuSelected = itemsOfMenu.first;
      videoModel = null;
      loadVideo();
    } finally {
      context.loaderOverlay.hide();
      setState(() {});
    }
  }

  onSelectedItem(YoutubeItem? model) {
    if (model == null || model.id == null || model.id?.videoId == null) {
      return;
    }

    NavigatorManager(context).fullModal(
      YoutubeFullScreen(videoId: model.id?.videoId ?? ''),
      fullscreenDialog: true,
    );
  }

  void openMenu() {
    NavigatorManager(context)
        .fullModal(const HomeMenu(), fullscreenDialog: true);
  }

  Future<void> onMenuSelected(VideoMenuModel model, int index) async {
    if (model.id == 0) {
      loadLive();
      return;
    }
    menuSelected = model;
    loadVideo();
  }

  loadVideo() async {
    context.loaderOverlay.show();
    setState(() {});
    Logger.log(menuSelected?.title);
    try {
      videoModel = await repository.videos(menuSelected?.url ?? '');
      scrollController.jumpTo(0);
    } catch (e) {
      videoModel = null;
      Logger.log(e.toString());
    } finally {
      context.loaderOverlay.hide();
      setState(() {});
    }
  }
}
