import 'package:flutter/material.dart';

import '../index.dart';

class ScheduleViewCard extends StatelessWidget {
  final Color backgroundColor;
  final ScheduleProgram? scheduleProgram;
  final ScheduleNowModel? scheduleNowPayload;
  const ScheduleViewCard({
    super.key,
    this.backgroundColor = Colors.white,
    this.scheduleProgram,
    this.scheduleNowPayload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(AppConstants.KPADDING_DEFAULT),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          CustomText(
            scheduleProgram?.time ?? '00:00',
            fontSize: AppConstants.KFONTSIZE_22,
          ),
          const SizedBox(width: AppConstants.KPADDING_DEFAULT),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  scheduleProgram?.programName ?? '',
                  textColor: AppColor.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  scheduleProgram?.daysOfTheWeek?.toWeekName ?? '',
                  textColor: const Color(0xFF404040),
                  fontSize: AppConstants.KFONTSIZE_12,
                  maxLines: 2,
                ),
                Visibility(
                  visible: scheduleProgram?.host != null &&
                      scheduleProgram!.host!.isNotEmpty,
                  child: CustomText(
                    '• ${scheduleProgram?.host} ',
                    textColor: const Color(0xFF404040),
                    fontSize: AppConstants.KFONTSIZE_12,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
