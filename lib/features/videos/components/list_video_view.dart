// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';

import '../../../../core/index.dart';

class ListVideoView extends StatelessWidget {
  final ScrollController scrollController;
  final VideoLiveModel? model;

  final Function(YoutubeItem? model)? onSelectedItem;

  const ListVideoView({
    super.key,
    required this.model,
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
          itemCount: model?.items?.length,
          itemBuilder: (BuildContext context, int index) {
            final item = model?.items?[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () => onSelectedItem?.call(item),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 200,
                    child: FadeInImage(
                      placeholderFit: BoxFit.fitHeight,
                      placeholder: const AssetImage(
                        'assets/images/logo_splash.png',
                      ),
                      image: NetworkImage(
                        item?.snippet?.thumbnails?.high?.url ?? '',
                      ),
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
                    item?.snippet?.title ?? '',
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
