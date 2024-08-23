import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../index.dart';

class CellMenuView extends StatelessWidget {
  final MenuHomeModel menu;
  final bool isHeader;
  final bool showFlag;
  const CellMenuView({
    super.key,
    required this.menu,
    this.isHeader = false,
    this.showFlag = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Container(
            width: 7,
            color: showFlag ? HexColor.fromHex(menu.color ?? '#CC0000') : null,
          ),
          Expanded(
            child: Column(
              children: [
                const Divider(
                  indent: AppConstants.KPADDING_8,
                  height: 0,
                  color: Color(0xFFE2E2E2),
                  thickness: 1,
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 18),
                      CustomText(
                        menu.label ?? '',
                        fontSize: AppConstants.KFONTSIZE_18,
                        fontWeight: FontWeight.w700,
                      ),
                      const Spacer(),
                      isHeader
                          ? SvgPicture.asset(
                              'assets/icons/arrow_back.svg',
                              width: 10,
                            )
                          : menu.items!.isNotEmpty
                              ? SvgPicture.asset(
                                  'assets/icons/arrow_forward.svg',
                                  width: 10,
                                )
                              : const SizedBox.shrink(),
                      const SizedBox(width: AppConstants.KPADDING_DEFAULT),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
