import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_template/core/helpers/shared_prefrences.dart';
import 'package:my_template/core/routing/app_router.dart';
import 'package:my_template/core/routing/routes.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/features/auth/logic/register_cubit/cubit.dart';
import 'package:my_template/features/home/logic/cubit/home_cubit.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    super.key,
    required this.appRouter,
  });

  Future<bool> _checkIfUserExists() async {
    final localStorageService = LocalStorageService();
    final user = await localStorageService.getUser();
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => RegisterCubit()), BlocProvider(create: (context) => HomeCubit())],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Skill-Tree',
          theme: ThemeData(
            primaryColor: ColorsManager.white,
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: Routes.onBoarding,
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }
}
