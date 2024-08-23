import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_constants.dart';
import 'custom_text.dart';

class AppBarInternal extends StatelessWidget {
  final String? title;
  final Widget? avatar;
  final Widget? titleWidget;
  final Widget? icon;
  final VoidCallback onIconPressed;
  final TextAlign textAlign;
  final Widget? trailing;
  const AppBarInternal({
    super.key,
    required this.onIconPressed,
    this.title,
    this.avatar,
    this.icon,
    this.textAlign = TextAlign.start,
    this.titleWidget,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.only(
        top: AppConstants.KPADDING_16 * 2.5,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: titleWidget ??
                CustomText(
                  title ?? '',
                  textAlign: textAlign,
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                ),
          ),
          Positioned(
              left: AppConstants.KPADDING_16,
              top: AppConstants.KPADDING_16 * 1.5,
              child: _createBackbutton()),
          Positioned(
              right: AppConstants.KPADDING_16,
              top: AppConstants.KPADDING_16 * 1.5,
              child: trailing ?? const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _createBackbutton() {
    return InkWell(
      onTap: onIconPressed,
      child: Container(
        padding: const EdgeInsets.only(
            top: 5, right: AppConstants.KPADDING_16, bottom: 5),
        child: icon ??
            SvgPicture.asset(
              'assets/icons/arrow_back.svg',
              height: 20,
            ),
      ),
    );
  }
}
