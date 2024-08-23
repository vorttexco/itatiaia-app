import 'package:flutter/material.dart';
import './youtube_full_screen_view.dart';

class YoutubeFullScreen extends StatefulWidget {
  static const route = '/YoutubeFullScreen/';
  final String videoId;
  const YoutubeFullScreen({super.key, required this.videoId});

  @override
  YoutubeFullScreenView createState() => YoutubeFullScreenView();
}
