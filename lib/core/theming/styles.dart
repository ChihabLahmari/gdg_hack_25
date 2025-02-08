import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_template/core/theming/font_weight_helper.dart';

class TextStyles {
  static TextStyle h1 = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: Colors.black,
  );

  static TextStyle title = TextStyle(
    fontSize: 42.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );
  static TextStyle h2 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.black,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.black,
  );
  static TextStyle h4 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.black,
  );
  static TextStyle p = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );
  static TextStyle blockquote = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.light,
    color: Colors.black,
  );
  static TextStyle subtle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );
  static TextStyle lead = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );

  static TextStyle small = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );

  static TextStyle text1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: Colors.black,
  );
}
