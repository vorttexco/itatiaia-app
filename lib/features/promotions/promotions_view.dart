import 'package:flutter/material.dart';

import '../../core/index.dart';
import './promotions_view_model.dart';

class PromotionsView extends PromotionsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomWebViewComponent(
        webViewController: webViewController,
        isLoading: isLoading,
      ),
    );
  }
}
