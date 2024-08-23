import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itatiaia_app/core/providers/tab_bar_provider.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../index.dart';

class PlayerView extends StatefulWidget {
  final ScheduleNowPayload? playNow;
  final CityPayload? currentRadioSelected;
  final List<ScheduleView> schedules;
  final VoidCallback onTapChooseCity;
  final Function(CityPayload? city)? onTapShare;
  const PlayerView({
    super.key,
    required this.playNow,
    required this.schedules,
    required this.currentRadioSelected,
    required this.onTapChooseCity,
    this.onTapShare,
  });

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  int tabSelected = 0;
  late TabController tabController;
  double volumePosition = 0.5;
  double heightList = 0;

  final nestedController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
    tabController.addListener(() {
      tabSelected = tabController.index;
      setState(() {});
    });
  }

  setExpaned() {
    setState(() {
      expanded = !expanded;
      Provider.of<TabbarProvider>(context, listen: false)
          .setHideBottomView(expanded);
      nestedController.jumpTo(0.0);
    });
  }

  Future<void> onSlideChange(double value) async {
    volumePosition = value;
    audioPlayerHandler.volume(value);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Durations.medium1,
      curve: Curves.easeIn,
      height: expanded ? AppConstants.screenHeight : 70,
      child: NestedScrollView(
        floatHeaderSlivers: false,
        controller: nestedController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              flexibleSpace: _createPlay(),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _createExpandedPlay(),
                  _createProgramView(),
                  _createWeekList(),
                ],
              ),
            )
          ];
        },
        body: _createWeekView(),
      ),
    );
  }

  Container _createPlay() {
    return Container(
      color: AppColor.primaryColor,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.KPADDING_16,
      ),
      child: Row(
        children: [
          StreamBuilder<bool>(
            stream: audioHandler.playbackState
                .map((state) => state.playing)
                .distinct(),
            builder: (context, snapshot) {
              final playing = snapshot.data ?? false;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (playing)
                    InkWell(
                      onTap: audioHandler.pause,
                      child: SvgPicture.asset('assets/icons/pause.svg',
                          width: 35, height: 35),
                    )
                  else
                    InkWell(
                      onTap: audioHandler.play,
                      child: SvgPicture.asset('assets/icons/play.svg',
                          width: 35, height: 35),
                    )
                ],
              );
            },
          ),
          const SizedBox(width: AppConstants.KPADDING_16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                widget.currentRadioSelected?.name ?? 'Ouça a rádio',
                textColor: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: AppConstants.KPADDING_4),
              const CustomText(
                'Tocando ao vivo',
                textColor: Color(0xFFFEC5CA),
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: setExpaned,
            child: Row(
              children: [
                CustomText(
                  expanded ? 'Reduzir' : 'Expandir',
                  textColor: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(width: 6),
                expanded
                    ? SvgPicture.asset(
                        'assets/icons/collapse_icon.svg',
                        width: 20,
                      )
                    : SvgPicture.asset(
                        'assets/icons/expand_icon.svg',
                        width: 20,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Visibility _createExpandedPlay() {
    return Visibility(
      visible: expanded,
      child: Container(
        color: AppColor.primaryColor,
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.KPADDING_DEFAULT, vertical: 8),
        child: Column(
          children: [
            Container(
              height: 112,
              padding: const EdgeInsets.all(AppConstants.KPADDING_DEFAULT),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  CustomText(
                    widget.playNow?.time ?? '00:00',
                    fontSize: AppConstants.KFONTSIZE_22,
                  ),
                  const SizedBox(width: AppConstants.KPADDING_DEFAULT),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          widget.playNow?.programName ?? '',
                          textColor: AppColor.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        const CustomText(
                          'Aos domingos, segundas, terças, quartas, quintas, sextas, e sábados',
                          textColor: Color(0xFF404040),
                          fontSize: AppConstants.KFONTSIZE_12,
                          maxLines: 2,
                        ),
                        const CustomText(
                          '',
                          textColor: Color(0xFF404040),
                          fontSize: AppConstants.KFONTSIZE_12,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: AppConstants.KPADDING_DEFAULT),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/pin_location.svg',
                  width: 17,
                  height: 20,
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    tabController.index = 0;
                    widget.onTapChooseCity();
                  },
                  child: Row(
                    children: [
                      CustomText(
                        widget.currentRadioSelected?.name ?? '',
                        textColor: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/icons/arrow_down.svg',
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      AppLabel.share,
                      textColor: Colors.white,
                    )),
                InkWell(
                  onTap: () =>
                      widget.onTapShare?.call(widget.currentRadioSelected),
                  child: SvgPicture.asset(
                    'assets/icons/share_icon.svg',
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _createProgramView() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(AppConstants.KPADDING_DEFAULT),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Programação',
            fontWeight: FontWeight.w700,
            fontSize: AppConstants.KFONTSIZE_30,
          ),
          Divider(
            height: AppConstants.KPADDING_DEFAULT * 2,
            thickness: 1,
            color: Color(0xFFE2E2E2),
          ),
          CustomText(
            'Tudo sobre o futebol mineiro, política, economia e informações de todo o Estado. A Itatiaia dá notícia de tudo.',
          )
        ],
      ),
    );
  }

  Visibility _createWeekList() {
    return Visibility(
      visible: expanded,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.KPADDING_DEFAULT),
        child: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          controller: tabController,
          labelPadding: const EdgeInsets.only(right: 38),
          indicatorColor: AppColor.primaryColor,
          indicatorWeight: 2,
          dividerHeight: 2,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.zero,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.5, color: Colors.red),
            insets: EdgeInsets.only(bottom: -1.5),
          ),
          unselectedLabelColor: const Color(0xFFCACACA),
          labelStyle: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700, color: AppColor.primaryColor),
          unselectedLabelStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
          padding: EdgeInsets.zero,
          tabs: widget.schedules.map((e) => Tab(text: e.day)).toList(),
        ),
      ),
    );
  }

  Widget _createWeekView() {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 32),
        child: TabBarView(
          controller: tabController,
          children: List.generate(
            widget.schedules.length,
            (index) {
              final weekSchedule = widget.schedules[index];
              if ((weekSchedule.schedules ?? []).isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(AppConstants.KPADDING_24),
                  child: CustomText(
                      'Ops. Esse dia não possui programação registrada.'),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(
                    parent: ClampingScrollPhysics()),
                padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.KPADDING_DEFAULT,
                    horizontal: AppConstants.KPADDING_DEFAULT),
                itemCount: weekSchedule.schedules?.length ?? 0,
                itemBuilder: (context, index) {
                  final scheduleProgram = weekSchedule.schedules?[index];
                  return ScheduleViewCard(
                    backgroundColor: const Color(0xFFF3F3F3),
                    scheduleProgram: scheduleProgram,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 12),
              );
            },
          ),
        ));
  }
}
