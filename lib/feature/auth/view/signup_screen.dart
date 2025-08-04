import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/app_logo.dart';
import '../../../core/global_widegts/app_button.dart';
import '../../../core/global_widegts/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var reEnterPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool isStudent = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                "Welcome back!",
                style: GoogleFonts.dmSerifText(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Let’s get started with a free account.",
                style: TextStyle(fontSize: 16, color: AppColors.secondaryBlackColor),
              ),
              const SizedBox(height: 30),

              // Toggle Buttons
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _buildToggleButton("Student", isStudent, () {
                      setState(() => isStudent = true);
                    }),
                    _buildToggleButton("Tutor", !isStudent, () {
                      setState(() => isStudent = false);
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Email
              CustomTextField(
                label: "Email",
                prefixIcon: Icon(Icons.email),
                controller: emailController,
              ),
              const SizedBox(height: 16),

              // Password
              CustomTextField(
                label: "Password",
                prefixIcon: Icon(Icons.lock),
                controller: passwordController,
                isPassword: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              CustomTextField(
                label: "Re enter password",
                prefixIcon: Icon(Icons.lock),
                controller: reEnterPasswordController,
                isPassword: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),

              SizedBox(height: 16),

              // Sign In
              AppButton(
                onTap: () {
                // Get.to(() => Dashboard());
                },
                text: "Sign In",
                buttonColor: AppColors.primaryColor,
                textColor: Colors.white,
              ),

              const SizedBox(height: 32),

              // Sign Up prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(fontSize: 16, color: AppColors.blackColor, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
