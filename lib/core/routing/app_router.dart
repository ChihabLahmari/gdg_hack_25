import 'package:flutter/material.dart';
import 'package:my_template/core/routing/routes.dart';
import 'package:my_template/features/auth/data/models/suggested_user.dart';
import 'package:my_template/features/auth/data/models/user.dart';
import 'package:my_template/features/auth/ui/onboarding_screen.dart';
import 'package:my_template/features/auth/ui/select_skills_image.dart';
import 'package:my_template/features/auth/ui/signin.dart';
import 'package:my_template/features/auth/ui/signup.dart';
import 'package:my_template/features/home/ui/buttom_nav_bar.dart';
import 'package:my_template/features/home/ui/field_description.dart';
import 'package:my_template/features/home/ui/project_view.dart';
import 'package:my_template/features/home/ui/quizs.dart';
import 'package:my_template/features/home/ui/user_profile.dart';

class HomeScreenParams {
  final List<Question>? questions;
  final String? userSpecificRecommondations;

  HomeScreenParams({
    required this.questions,
    required this.userSpecificRecommondations,
  });
}

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // this argument to be passed in any screen like this ( arguments as ClassName)
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BottomNavigationBarExample(),
        );
      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => SignInView(),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => SignUpView(),
        );

      case Routes.selectSkillsAndImage:
        return MaterialPageRoute(
          builder: (_) => SelectSkillsAndImageView(),
        );
      case Routes.projectView:
        return MaterialPageRoute(
          builder: (_) => ProjectView(),
        );
      case Routes.quizView:
        return MaterialPageRoute(
          builder: (_) => QuizScreen(),
        );

      case Routes.userProfile:
        return MaterialPageRoute(
          builder: (_) => UserProfileView(user: args as SuggestedUser),
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => OnboardingScreen(),
        );

      case Routes.fieldDescription:
        return MaterialPageRoute(
          builder: (_) => FieldDescriptionView(title: args as String),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
