import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_template/core/theming/colors.dart';

import '../theming/styles.dart';

class MyTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String labelText;
  final bool isPassword;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;

  const MyTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.labelText,
    this.isPassword = false,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool _obscureText = true; // Password visibility state

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword; // Initially obscure if it's a password field
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyles.p,
        ),
        SizedBox(height: 8.h), // Space between label and input field
        SizedBox(
          height: 60.h, // Set a consistent height for all form fields
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h), // Adjusted padding for vertical centering
              focusedBorder: widget.focusedBorder ??
                  OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.gray, // Grey border
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
              enabledBorder: widget.enabledBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey, // Grey border
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              filled: true,
              fillColor: Colors.white, // White background
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // Toggle visibility
                        });
                      },
                    )
                  : widget.suffixIcon, // Use provided suffix icon if not a password field
              errorStyle: TextStyle(
                fontSize: 12.sp, // Adjust error text size
                height: 1.0, // Ensure error text doesn't overflow
              ),
            ),
            style: TextStyles.h4.copyWith(
              height: 1.0, // Ensure text is vertically centered
            ),
            validator: (value) {
              return widget.validator(value);
            },
          ),
        ),
      ],
    );
  }
}
