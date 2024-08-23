import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itatiaia_app/core/components/custom_app_bar.dart';
import 'package:itatiaia_app/core/providers/tab_bar_provider.dart';
import 'package:provider/provider.dart';

import '../../core/index.dart';
import './tab_navigator_view_model.dart';

class TabNavigatorView extends TabNavigatorViewModel {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabbarProvider>(
      builder:
          (BuildContext context, TabbarProvider tabbarProvider, Widget? child) {
        return Scaffold(
          backgroundColor: AppColor.primaryColor,
          bottomNavigationBar: (tabbarProvider.hideBottomView ||
                  tabbarProvider.isVideoFullScreen)
              ? null
              : _buildBottomNavigator(),
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Visibility(
                  visible: !tabbarProvider.isVideoFullScreen,
                  child: PlayerView(
                    playNow: playNow,
                    currentRadioSelected: currentRadioSelected,
                    schedules: WrapperWeekSchedule.toView(scheduleModel),
                    onTapChooseCity: onTapChooseCity,
                    onTapShare: onTapShare,
                  ),
                ),
                Visibility(
                  visible: !tabbarProvider.isVideoFullScreen,
                  child: CustomAppBar(
                    onTapMenu: openMenu,
                    title: widgetTitle(),
                    onTapSettings: openSettigns,
                  ),
                ),
                Expanded(child: pages[tabIndex]),
              ],
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBar _buildBottomNavigator() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: tabIndex,
      backgroundColor: AppColor.primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
          fontFamily: 'CNN Sans Display',
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w400),
      unselectedLabelStyle: const TextStyle(
          fontFamily: 'CNN Sans Display',
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w400),
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/home_off.svg'),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/home_on.svg'),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/ao_vivo_off.svg'),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/ao_vivo_on.svg'),
          ),
          label: 'Videos',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/sport_off.svg'),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/sport_on.svg'),
          ),
          label: 'Esportes',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/promotion_off.svg'),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/promotion_on.svg'),
          ),
          label: 'Promoções',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/search_off.svg'),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/icons/search_on.svg'),
          ),
          label: 'Busca',
        ),
      ],
    );
  }
}
