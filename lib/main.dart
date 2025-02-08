import 'package:flutter/material.dart';
import 'package:my_template/core/di/dependency_injection.dart';
import 'package:my_template/core/routing/app_router.dart';
import 'package:my_template/my_app.dart';

void main() {
  setUpGetIt();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}
