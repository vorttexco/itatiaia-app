import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_constants.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onTapMenu;
  final VoidCallback onTapSettings;
  final Widget title;
  const CustomAppBar({
    super.key,
    required this.onTapMenu,
    required this.onTapSettings,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMenuButton(),
          Expanded(child: title),
          _buildSettingsButton(),
        ],
      ),
    );
  }

  Widget _buildSettingsButton() {
    return InkWell(
      onTap: onTapSettings,
      child: SvgPicture.asset('assets/icons/settings_icon.svg'),
    );
  }

  Widget _buildMenuButton() {
    return InkWell(
      onTap: onTapMenu,
      child: Container(
        padding: const EdgeInsets.only(top: 5, right: AppConstants.KPADDING_16),
        child: SvgPicture.asset('assets/icons/menu.svg'),
      ),
    );
  }
}
