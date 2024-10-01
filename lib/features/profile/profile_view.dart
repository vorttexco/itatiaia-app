import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/index.dart';
import './profile_view_model.dart';

class ProfileView extends ProfileViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          AppLabel.settings,
          fontSize: AppConstants.KFONTSIZE_18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          const Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Color(0xFFD6D6D6),
            thickness: 1,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () {
              OneSignal.InAppMessages.addTrigger('open-config', 'true');
            },
            title: const CustomText(
              'Notificações',
              fontWeight: FontWeight.w400,
            ),
            subtitle: const CustomText(
                'Configure o recebimento de notificações',
                fontSize: 12),
            trailing: SvgPicture.asset('assets/icons/arrow_forward.svg'),
          ),
          const SizedBox(height: 4),
          const Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Color(0xFFD6D6D6),
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            itemCount: listOfMenu.length,
            itemBuilder: (BuildContext context, int index) {
              final menu = listOfMenu[index];
              return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  onTap: () => openLink(menu),
                  dense: true,
                  title:
                      CustomText(menu.label ?? '', fontWeight: FontWeight.w400),
                  trailing: SvgPicture.asset('assets/icons/arrow_forward.svg'));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              indent: AppConstants.KPADDING_DEFAULT,
              endIndent: AppConstants.KPADDING_DEFAULT,
              color: Color(0xFFD6D6D6),
              thickness: 1,
            ),
          ),
          const SizedBox(height: 4),
          const Divider(
            indent: AppConstants.KPADDING_DEFAULT,
            endIndent: AppConstants.KPADDING_DEFAULT,
            color: Color(0xFFD6D6D6),
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
