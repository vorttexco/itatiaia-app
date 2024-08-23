import 'package:flutter/material.dart';

import '../../core/index.dart';
import './sports_view_model.dart';

class SportsView extends SportsViewModel {
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
