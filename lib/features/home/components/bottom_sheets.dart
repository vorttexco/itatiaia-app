import 'package:flutter/material.dart';

import '../../../core/index.dart';

class CustomBottomSheets extends StatelessWidget {
  final List<CityPayload> items;
  final Function(CityPayload city) onItemSelected;

  const CustomBottomSheets({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(25),
            child: CustomText(
              'Escolha sua cidade:',
              textColor: Colors.white,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final city = items[index];
              return InkWell(
                onTap: () => onItemSelected(city),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: CustomText(
                        city.name ?? '',
                        fontWeight: FontWeight.w700,
                        textColor: AppColor.primaryColor,
                        fontSize: AppConstants.KFONTSIZE_16,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFFC40021),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: CustomText(
                    AppLabel.cancel,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    fontSize: AppConstants.KFONTSIZE_16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25)
        ],
      ),
    );
  }
}
