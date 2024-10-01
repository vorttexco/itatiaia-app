import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_constants.dart';
import 'custom_text.dart';

class AppBarwebView extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? icon;
  final VoidCallback onIconPressed;
  final TextAlign textAlign;
  final Color backgroundColor;
  final VoidCallback? onFinished;
  final VoidCallback? onShare;
  final Color iconColor;

  const AppBarwebView({
    super.key,
    required this.onIconPressed,
    this.title,
    this.icon,
    this.textAlign = TextAlign.start,
    this.titleWidget,
    this.backgroundColor = Colors.white,
    this.onFinished,
    this.iconColor = Colors.white,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: backgroundColor,
      padding: const EdgeInsets.only(
        left: AppConstants.KPADDING_16,
        right: AppConstants.KPADDING_16,
        top: AppConstants.KPADDING_16 * 2.5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _createBackbutton(),
          Expanded(
            child: InkWell(
              onTap: onIconPressed,
              child: SizedBox(
                child: titleWidget ??
                    CustomText(
                      title ?? '',
                      textAlign: textAlign,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                      fontSize: AppConstants.KFONTSIZE_18,
                    ),
              ),
            ),
          ),
          Visibility(
            visible: onShare != null,
            child: IconButton(
              onPressed: onShare,
              icon: const Icon(Icons.ios_share_sharp),
            ),
          )
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
