import 'package:flutter/material.dart';

class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

final List<OnboardingData> pages = [
  OnboardingData(
    title: "Your Learning Adventure Begins",
    description: "Join our community of learners and educators to enhance your skills.",
    image: "assets/images/onboarding_screen1.png",
  ),
  OnboardingData(
    title: "Explore Your Diverse Subjects",
    description: "Discover a wide range of subjects taught by experienced tutors from around the world.",
    image: "assets/images/onboarding_screen2.png",
  ),
  OnboardingData(
    title: "Personalized Learning Journey",
    description: "Tailor your learning experience with one-on-one sessions and custom study plans.",
    image: "assets/images/onboarding_screen3.png",
  ),
];