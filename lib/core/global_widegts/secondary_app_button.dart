import 'package:flutter/material.dart';

import '../const/app_colors.dart';
import '../style/global_text_style.dart';

class SecondaryAppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final IconData? icon;
  final String? imagePath; // ✅ only this needed

  const SecondaryAppButton({
    required this.onTap,
    required this.text,
    this.buttonColor = AppColors.secondaryColor,
    this.textColor = AppColors.primaryColor,
    this.borderColor = Colors.transparent,
    this.icon,
    this.imagePath, // ✅ constructor
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = imagePath != null && (imagePath!.startsWith('http') || imagePath!.startsWith('https'));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: textColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
