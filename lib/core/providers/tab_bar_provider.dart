import 'package:flutter/material.dart';

class TabbarProvider with ChangeNotifier {
  bool _hideBottomView = false;
  bool get hideBottomView => _hideBottomView;

  void setHideBottomView(bool value) {
    _hideBottomView = value;
    notifyListeners();
  }

  bool _reloadHome = false;
  bool get reloadHome => _reloadHome;

  void setReloadHome(bool value) {
    _reloadHome = value;
    notifyListeners();
  }

  bool _isVideoFullScreen = false;
  bool get isVideoFullScreen => _isVideoFullScreen;

  void setVideoFullScreen(bool value) {
    _isVideoFullScreen = value;
    notifyListeners();
  }

  bool _reloadStore = false;
  bool get reloadStore => _reloadStore;

  void setReloadStore(bool value) {
    _reloadStore = value;
    notifyListeners();
  }
}
