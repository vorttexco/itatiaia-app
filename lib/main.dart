import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itatiaia_app/core/app/index.dart';
import 'package:itatiaia_app/core/index.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'core/commons/player/audio_player_handler.dart';
import 'core/providers/tab_bar_provider.dart';

// ignore: unused_element
// late AudioHandler audioHandler;

late AudioPlayerHandler audioPlayerHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.initialize(AppConstants.ONESIGNAL_KEY);

  OneSignal.Notifications.requestPermission(true);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColor.primaryColor,
    statusBarIconBrightness: Brightness.light,
  ));

  final radios =
      await StorageManager().getString(AppConstants.SHARED_PREFERENCES_RADIOS);

  if (radios != null) {
    final library = MediaLibrary();
    final List<MediaItem> items = List.empty(growable: true);

    for (var radio in radios.split(';')) {
      final radioJson = await StorageManager().getString(radio);

      if (radioJson != null) {
        final city = CityPayload.fromJson(jsonDecode(radioJson));

        final mediaItem = MediaItem(
          id: city.radioStreamingUrl ?? '',
          title: city.name ?? '',
          artist: 'Tocando ao vivo',
          artUri: Uri.parse(AppConstants.LOGO_AUDIO_BG),
        );

        items.add(mediaItem);
      }
    }

    library.items = <String, List<MediaItem>>{
      AudioService.browsableRootId: [
        const MediaItem(
          id: MediaLibrary.albumsRootId,
          title: "Radios",
          playable: false,
        ),
      ],
      MediaLibrary.albumsRootId: items,
    };

    audioPlayerHandler = await AudioService.init(
      builder: () => AudioPlayerHandlerImpl(library),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'br.com.itatiaia.channel.id',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );
  } else {
    audioPlayerHandler = await AudioService.init(
      builder: () => AudioPlayerHandlerImpl(MediaLibrary()),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'br.com.itatiaia.channel.id',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.white.withOpacity(0.6),
      overlayHeight: 80,
      overlayWidth: 80,
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          ),
        );
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TabbarProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Itatiaia',
          theme: ThemeData(
              textTheme: GoogleFonts.dmSansTextTheme(),
              useMaterial3: true,
              scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColor.scaffoldBackgroundColor,
              )),
          onGenerateRoute: AppRouters.generateRoute,
        ),
      ),
    );
  }
}
