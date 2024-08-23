import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/index.dart';
import './home_menu_view_model.dart';

class HomeMenuView extends HomeMenuViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarInternal(
            icon: SvgPicture.asset('assets/icons/close_menu.svg'),
            onIconPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.KPADDING_DEFAULT,
                  vertical: AppConstants.KPADDING_DEFAULT),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final menu = listOfMenu[index];
                  return ListTile(
                    onTap: () => openMenu(menu),
                    contentPadding: EdgeInsets.zero,
                    minTileHeight: 50,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                              color: HexColor.fromHex(menu.color ?? '#CC0000'),
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          menu.label ?? '',
                          fontSize: AppConstants.KFONTSIZE_18,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    trailing: menu.items!.isEmpty
                        ? null
                        : const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 19,
                          ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: HexColor.fromHex('#E2E2E2'),
                ),
                itemCount: listOfMenu.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
