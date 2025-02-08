import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_template/core/theming/colors.dart';

class SignupText extends StatelessWidget {
  final VoidCallback onTap;

  const SignupText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.vibrantPink, // Required for ShaderMask to work
            ),
          ),
        ),
      ],
    );
  }
}
