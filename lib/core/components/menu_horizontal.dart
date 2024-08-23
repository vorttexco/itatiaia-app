import 'package:flutter/material.dart';

import '../index.dart';

class MenuHorizontal extends StatefulWidget {
  final List<MenuHomeModel> items;
  final Color? backgroundColor;
  final Color? textColor;
  final Function(MenuHomeModel menu, int index)? onSelectedMenu;
  final bool showBottomLine;
  final ScrollController? scrollController;
  final int selectedIndex;

  const MenuHorizontal({
    super.key,
    required this.items,
    this.onSelectedMenu,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.showBottomLine = true,
    this.scrollController,
    this.selectedIndex = 0,
  });

  @override
  State<MenuHorizontal> createState() => _MenuHorizontalState();
}

class _MenuHorizontalState extends State<MenuHorizontal> {
  onSelectedItem(MenuHomeModel item, int index) {
    widget.onSelectedMenu?.call(item, index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: widget.showBottomLine
                ? const Color(0xFFDCDCDC)
                : Colors.transparent,
          ),
        ),
      ),
      height: 50,
      child: ListView.separated(
        controller: widget.scrollController,
        padding: const EdgeInsets.only(left: AppConstants.KPADDING_16),
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final menu = widget.items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => onSelectedItem(menu, index),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 3,
                    color: widget.selectedIndex == index
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
                              color: HexColor.fromHex(menu.color ?? '#CC0000'),
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        const SizedBox(width: 8),
                        CustomText(
                          menu.label ?? '',
                          fontWeight: FontWeight.w700,
                          textColor: widget.textColor,
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
