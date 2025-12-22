import 'package:flutter/material.dart';

enum AppFlowState { onboarding, location, home }

class AppFlowViewModel extends ChangeNotifier {
  AppFlowState state = AppFlowState.onboarding;
  int currentPage = 0;

  void updatePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void finishOnboarding() {
    state = AppFlowState.location;
    notifyListeners();
  }

  void goToHome() {
    state = AppFlowState.home;
    notifyListeners();
  }
}
