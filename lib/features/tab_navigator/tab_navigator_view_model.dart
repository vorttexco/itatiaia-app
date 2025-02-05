import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/index.dart';
import '../../core/providers/tab_bar_provider.dart';
import '../../main.dart';
import '../home/components/bottom_sheets.dart';
import '../index.dart';

abstract class TabNavigatorViewModel extends State<TabNavigator> {
  final homeRepository = HomeRepository(ApiConnector());

  CityModel? cityModel;
  CityScheduleModel? scheduleModel;
  ScheduleNowModel? scheduleNowModel;

  CityPayload? currentRadioSelected;
  ScheduleNowPayload? playNow;
  int tabIndex = 0;
  final List<Widget> pages = [
    const Home(),
    const Videos(),
    const Sports(),
    const Promotions(),
    const Search(),
  ];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadView();
    });
  }

  Future<void> onTabTapped(int index) async {
    if (index == 3) {
      Provider.of<TabbarProvider>(context, listen: false).setReloadStore(true);
    }

    if (index == 0) {
      Provider.of<TabbarProvider>(context, listen: false).setReloadHome(true);
    }
    setState(() {
      tabIndex = index;
    });
  }

  loadView() async {
    try {
      cityModel = await homeRepository.cities();

      scheduleModel =
          await homeRepository.schedule(currentRadioSelected?.uid ?? '');

      scheduleNowModel =
          await homeRepository.scheduleNow(currentRadioSelected?.uid ?? '');
      playNow = scheduleNowModel?.payload;

      currentRadioSelected = await homeRepository.currentRadio();
      if (currentRadioSelected == null) {
        onTapChooseCity();
      } else {
        loadCity();
      }
    } on Exception catch (e) {
      Logger.log(e.toString());
    } finally {
      setState(() {});
    }
  }

  onTapChooseCity() async {
    if (cityModel == null || cityModel!.payload == null) {
      return;
    }
    NavigatorManager(context).modal(
      CustomBottomSheets(
          items: cityModel?.payload ?? [],
          onItemSelected: (city) {
            currentRadioSelected = city;
            loadCity();
            Navigator.pop(context);
          }),
      enableDrag: false,
      backgroudColor: Colors.transparent,
    );
  }

  loadCity() async {
    try {
      homeRepository.saveCurrentRadio(currentRadioSelected!);
      scheduleModel =
          await homeRepository.schedule(currentRadioSelected?.uid ?? '');

      scheduleNowModel =
          await homeRepository.scheduleNow(currentRadioSelected?.uid ?? '');
      playNow = scheduleNowModel?.payload;

      // for (CityPayload city in cityModel?.payload ?? []) {
      //   if (city.name == currentRadioSelected?.name) {
      //     continue;
      //   }

      //   final mediaItem = MediaItem(
      //     id: city.radioStreamingUrl ?? '',
      //     title: city.name ?? '',
      //     artist: 'Tocando ao vivo',
      //     artUri: Uri.parse(AppConstants.LOGO_AUDIO_BG),
      //   );

      //   await audioPlayerHandler.addQueueItem(mediaItem);
      // }

      // final mediaItem = MediaItem(
      //   id: currentRadioSelected?.radioStreamingUrl ?? '',
      //   title: currentRadioSelected?.name ?? '',
      //   artist: 'Tocando ao vivo',
      //   artUri: Uri.parse(AppConstants.LOGO_AUDIO_BG),
      // );

      // await audioPlayerHandler.prepareToPlay(mediaItem);
      await audioPlayerHandler.play();
    } finally {
      setState(() {});
    }
  }

  void onTapShare(CityPayload? city) {
    if (city != null) {
      Share.share(
        'Ouça nossa rádio em  ${city.radioStreamingUrl}',
        subject: AppLabel.appName,
      );
    }
  }

  void openMenu() {
    NavigatorManager(context)
        .fullModal(const HomeMenu(), fullscreenDialog: true);
  }

  void openSettigns() {
    NavigatorManager(context)
        .fullModal(const Profile(), fullscreenDialog: true);
  }

  Widget widgetTitle() {
    if (tabIndex == 0) {
      return InkWell(
        onTap: () {
          Provider.of<TabbarProvider>(context, listen: false)
              .setReloadHome(true);
        },
        child: SizedBox(
          height: 18,
          child: SvgPicture.asset('assets/icons/logo_app_bar.svg'),
        ),
      );
    }

    String title = AppLabel.appName;

    switch (tabIndex) {
      case 1:
        title = 'Video';
        break;
      case 2:
        title = 'Esportes';
        break;
      case 3:
        title = 'Loja';
        break;
      case 4:
        title = 'Buscar';
        break;

      default:
    }

    return CustomText(
      title,
      fontSize: AppConstants.KFONTSIZE_18,
      fontWeight: FontWeight.w700,
      textColor: Colors.black,
      textAlign: TextAlign.center,
    );
  }
}
