import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:tuitioni/feature/auth/view/reset_password_screen.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/global_widegts/app_button.dart';


class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Verify OTP', style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              'We have just sent a 4 digit code to your phone\n+1***555-0103. Please check and enter the code below.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 40),

            PinCodeTextField(
              appContext: context,
              controller: otpController,
              length: 4,
              autoFocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                fieldHeight: 60,
                fieldWidth: 60,
                inactiveColor: Colors.grey.shade300,
                activeColor: AppColors.primaryColor,
                selectedColor: AppColors.primaryColor,
              ),
              cursorColor: AppColors.primaryColor,
              onChanged: (value) {
                setState(() => currentText = value);
              },
              onCompleted: (value) {},
            ),

            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                text: "Didn't receive code? ",
                style: const TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: "Request again",
                    style: const TextStyle(color: AppColors.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Resend OTP requested')),
                        );
                      },
                  )
                ],
              ),
            ),

            const Spacer(),

            AppButton(
              onTap: currentText.length == 4
                  ? () => Get.to(() => ResetPasswordScreen())
                  : () {},
              text: "Verify",
              buttonColor: currentText.length == 4
                  ? AppColors.primaryColor
                  : Colors.grey.shade300,
              textColor: AppColors.bgColor,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
