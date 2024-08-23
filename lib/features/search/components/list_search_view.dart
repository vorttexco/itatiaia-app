import 'package:flutter/material.dart';
import 'package:itatiaia_app/core/models/search_model.dart';

import '../../../../core/index.dart';

class ListSearchView extends StatelessWidget {
  final ScrollController scrollController;
  final List<SearchPayload> items;

  final Function(SearchPayload model)? onSelectedItem;

  const ListSearchView({
    super.key,
    required this.items,
    this.onSelectedItem,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.zero,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () => onSelectedItem?.call(item),
                  child: SizedBox(
                    height: 180,
                    child: FadeInImage(
                      placeholderFit: BoxFit.scaleDown,
                      placeholder: const AssetImage(
                        'assets/images/logo_splash.png',
                      ),
                      image: NetworkImage(item.mainImage ?? ''),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.black,
                          child: Center(
                            child: Image.asset(
                              'assets/images/logo_splash.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        );
                      },
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.KPADDING_16),
                  child: CustomText(
                    item.headline ?? '',
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black,
                  ),
                )
              ],
            );
          }),
    );
  }
}
