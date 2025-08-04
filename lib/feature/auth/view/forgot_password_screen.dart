import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuitioni/feature/auth/view/verify_otp_screen.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/global_widegts/app_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String selectedOption = 'sms';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Select a contact details. We will send a code to your phone or email to reset your password.',
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 30),

            // SMS Option
            buildOptionCard(
              icon: Icons.sms,
              title: 'Via SMS',
              subtitle: '+1*** 555-0103',
              value: 'sms',
            ),

            const SizedBox(height: 20),

            // Email Option
            buildOptionCard(
              icon: Icons.email,
              title: 'Via Email',
              subtitle: 'alb****@gmail.com',
              value: 'email',
            ),

            const Spacer(),
            AppButton(
              onTap: () {
                Get.to(()=>VerifyOtpScreen());// OTP navigation logic
              },
              text: "Get OTP",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final isSelected = selectedOption == value;

    return GestureDetector(
      onTap: () => setState(() => selectedOption = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? AppColors.primaryColor.withOpacity(0.05) : Colors.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(icon, color: AppColors.primaryColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black87)),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: selectedOption,
              onChanged: (val) => setState(() => selectedOption = val!),
              activeColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
