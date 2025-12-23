import 'package:flutter/material.dart';

enum AppFlowState { onboarding, location, home }

class AppFlowViewModel extends ChangeNotifier {
  AppFlowState state = AppFlowState.onboarding;
  int currentPage = 0;

  var location;

  void updatePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void finishOnboarding() {
    state = AppFlowState.location;
    notifyListeners();
  }

  void goToHome(String s) {
    state = AppFlowState.home;
    notifyListeners();
  }
}
