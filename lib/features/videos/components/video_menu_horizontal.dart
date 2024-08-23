import 'package:flutter/material.dart';
import 'package:itatiaia_app/features/videos/models/video_menu_model.dart';

import '../../../core/index.dart';

class VideoMenuHorizontal extends StatelessWidget {
  final List<VideoMenuModel> items;
  final Function(VideoMenuModel model, int index)? onSelectedMenu;
  final VideoMenuModel? selectedItem;
  final ScrollController? scrollController;

  const VideoMenuHorizontal({
    super.key,
    this.onSelectedMenu,
    this.scrollController,
    required this.items,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFFDCDCDC)),
        ),
      ),
      height: 50,
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.only(left: AppConstants.KPADDING_16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final menu = items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => onSelectedMenu?.call(menu, index),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 3,
                    color: selectedItem?.id == menu.id
                        ? const Color(0xFFCC0000)
                        : Colors.transparent,
                  ))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12, left: 1, right: 1),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                              color: HexColor.fromHex('#CC0000'),
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        const SizedBox(width: 8),
                        CustomText(
                          menu.title,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //     : const SizedBox.shrink()
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 28,
        ),
      ),
    );
  }
}
