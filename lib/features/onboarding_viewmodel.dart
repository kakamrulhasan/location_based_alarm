import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingViewModel extends ChangeNotifier {
  int currentPage = 0;

  void updatePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onboarding_done", true);

    // Navigation will be added later
  }
}
