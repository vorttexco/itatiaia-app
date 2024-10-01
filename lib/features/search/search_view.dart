import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itatiaia_app/features/search/components/list_search_view.dart';

import '../../core/index.dart';
import './search_view_model.dart';

class SearchView extends SearchViewModel {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.KPADDING_DEFAULT),
              child: Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.KPADDING_DEFAULT,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFD6D6D6),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/search_off.svg',
                      colorFilter: const ColorFilter.mode(
                          Color(0xFF282828), BlendMode.srcIn),
                    ),
                    const SizedBox(width: AppConstants.KPADDING_DEFAULT),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Pesquisar na Itatiaia',
                          hintStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF757575)),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onChanged: onSearch,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppConstants.KPADDING_DEFAULT),
            const Divider(
              height: 1,
              color: Color(0xFFDCDCDC),
              thickness: 1,
            ),
            Expanded(
              child: ListSearchView(
                items: listOfResult,
                onSelectedItem: onSelectedItem,
                scrollController: scrollController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
