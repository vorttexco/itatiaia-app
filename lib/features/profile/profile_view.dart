import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: ListView.separated(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: listOfMenu.length,
        itemBuilder: (BuildContext context, int index) {
          final menu = listOfMenu[index];
          return SizedBox(
            height: 50,
            child: ListTile(
                onTap: () => openLink(menu),
                dense: true,
                title:
                    CustomText(menu.label ?? '', fontWeight: FontWeight.w400),
                trailing: SvgPicture.asset('assets/icons/arrow_forward.svg')),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          indent: AppConstants.KPADDING_DEFAULT,
          endIndent: AppConstants.KPADDING_DEFAULT,
          color: Color(0xFFD6D6D6),
          thickness: 1,
        ),
      ),
    );
  }
}
