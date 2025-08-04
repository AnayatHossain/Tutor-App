import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitioni/feature/auth/view/signup_screen.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/app_logo.dart';
import '../../../core/global_widegts/app_button.dart';
import '../../../core/global_widegts/custom_text_field.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                "Please enter your details.",
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
              const SizedBox(height: 12),

              // Remember me and Forgot password
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) => setState(() => rememberMe = value!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    activeColor: AppColors.primaryColor,
                    checkColor: Colors.white,
                    side: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  const Text("Remember me", style: TextStyle(fontSize: 16, color: AppColors.blackColor)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

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
                  const Text("Don’t have an account? ", style: TextStyle(fontSize: 16, color: AppColors.blackColor, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignupScreen());
                    },
                    child: Text(
                      "Sign up",
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
