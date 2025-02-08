import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:my_template/core/theming/colors.dart';

CherryToast errorToast(String msg) {
  return CherryToast.error(
    title: Text(msg, style: TextStyle(color: Colors.red)),
    backgroundColor: ColorsManager.white,
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}

CherryToast successToast(String msg) {
  return CherryToast.success(
    title: Text(msg, style: TextStyle(color: ColorsManager.black)),
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}
