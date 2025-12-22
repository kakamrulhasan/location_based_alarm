import 'package:flutter/material.dart';
import 'package:flutter_application_17/common_widgets/onboarding_page.dart';
import 'package:flutter_application_17/common_widgets/gradient_container.dart'; // <-- import gradient
import 'package:flutter_application_17/constants/app_colors.dart';
import 'package:flutter_application_17/constants/app_texts.dart';
import 'package:flutter_application_17/features/onboarding_viewmodel.dart';
import 'package:flutter_application_17/networks/image_urls.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppFlowViewModel>();

    return Scaffold(
      body: GradientContainer( // <-- use GradientContainer here
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView(
                      controller: _controller,
                      onPageChanged: vm.updatePage,
                      children: const [
                        OnboardingPage(
                          imageUrl: ImageUrls.onboarding1,
                          title: AppTexts.title1,
                          description: AppTexts.desc1,
                        ),
                        OnboardingPage(
                          imageUrl: ImageUrls.onboarding2,
                          title: AppTexts.title2,
                          description: AppTexts.desc2,
                        ),
                        OnboardingPage(
                          imageUrl: ImageUrls.onboarding3,
                          title: AppTexts.title3,
                          description: AppTexts.desc3,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 56,
                      right: 16,
                      child: TextButton(
                        onPressed: vm.finishOnboarding,
                        child: const Text(
                          AppTexts.skip,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: const Color.fromARGB(255, 110, 79, 245),
                  dotColor: Colors.white12,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onPressed: () {
                      if (vm.currentPage == 2) {
                        vm.finishOnboarding();
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
