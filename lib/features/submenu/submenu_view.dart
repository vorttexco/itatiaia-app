import 'package:flutter/material.dart';

import '../../core/index.dart';
import './submenu_view_model.dart';

class SubmenuView extends SubmenuViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: InkWell(
                onTap: onBack,
                child: CellMenuView(
                  menu: widget.model,
                  isHeader: true,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 2),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final menu = widget.model.items![index];
                  return InkWell(
                    onTap: () => openMenu(menu),
                    child: CellMenuView(
                      menu: menu,
                      showFlag: false,
                    ),
                  );
                },
                itemCount: widget.model.items!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
