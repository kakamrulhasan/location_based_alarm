import 'package:flutter/material.dart';
import 'package:flutter_application_17/common_widgets/onboarding_page.dart';
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
  Widget build(BuildContext context) {
    final vm = context.watch<OnboardingViewModel>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 28, 20, 143),
              Color.fromARGB(255, 14, 6, 74),
              Color.fromARGB(255, 24, 11, 112),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
                        onPressed: vm.completeOnboarding,
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

              /// Dots Indicator
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

              /// Next Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 76, 49, 200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onPressed: () {
                      if (vm.currentPage == 2) {
                        vm.completeOnboarding();
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
