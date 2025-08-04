import 'package:flutter/material.dart';
import '../const/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final Widget? prefixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.controller,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _isFocused ? AppColors.primaryColor : Colors.transparent;
    final fillColor = _isFocused ? AppColors.secondaryColor : const Color(0xFFF8F8F8);
    final iconColor = _isFocused ? AppColors.primaryColor : AppColors.blackColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        focusNode: _focusNode,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.blackColor,
        ),
        decoration: InputDecoration(
          hintText: widget.label,
          hintStyle: TextStyle(
            fontSize: 14,
            color: AppColors.blackColor,
          ),
          prefixIcon: widget.prefixIcon != null
              ? IconTheme(
            data: IconThemeData(color: iconColor),
            child: widget.prefixIcon!,
          )
              : null,
          suffixIcon: widget.suffixIcon ??
              (widget.isPassword
                  ? Icon(Icons.visibility_off, color: iconColor)
                  : null),
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
        ),
      ),
    );
  }
}
