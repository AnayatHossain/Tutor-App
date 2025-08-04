import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitioni/core/global_widegts/app_button.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/global_widegts/secondary_app_button.dart';
import '../../auth/view/login_screen.dart';
import '../model/onboarding_data.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Image.asset(
                pages[_currentPage].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                data: pages[index],
                pageController: _pageController,
                currentPage: _currentPage,
              );
            },
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final PageController pageController;
  final int currentPage;

  const OnboardingPage({
    required this.data,
    required this.pageController,
    required this.currentPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 380,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.bgColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.title,
              style: GoogleFonts.dmSerifText(
                color: AppColors.blackColor,
                fontSize: 30,
                height: 1,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            Text(
              data.description,
              style: TextStyle(
                color: AppColors.blackColor.withOpacity(0.7),
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 32),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 7,
                  width: currentPage == index ? 32 : 8,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(currentPage == index ? 1 : 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),

            // Skip and next button
            currentPage != pages.length - 1
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SecondaryAppButton(onTap: (){
                    Get.to(()=>LoginScreen());
                  }, text: "Skip")

                ),
                const SizedBox(width: 16),
                Expanded(
                  
                  child: AppButton(onTap: () {
                      if (currentPage < pages.length - 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                  }, text: "Next"),
                ),
              ],
            )
                : Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppButton(onTap: (){
                    Get.to(()=>LoginScreen());
                  }, text: "Get Started")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}