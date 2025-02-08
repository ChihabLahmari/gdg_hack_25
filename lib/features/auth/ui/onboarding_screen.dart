import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_template/core/routing/extensions.dart';
import 'package:my_template/core/routing/routes.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Pathway!",
          body:
              "Pathway helps you achieve your dream career with AI-generated roadmaps tailored to your goals. Learn step by step and stay on track with a structured path designed just for you",
          image: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset("assets/images/onboarding_1.png", width: 350),
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyles.h3.copyWith(color: ColorsManager.blue),
            bodyTextStyle: TextStyles.subtle,
          ),
        ),
        PageViewModel(
          title: " Learn & Collaborate",
          body:
              "Connect with students who share your interests! Work together, build projects, and gain real-world experience with the support of mentors guiding you through key milestones",
          image: Image.asset("assets/images/onboarding_2.png", width: 350),
          decoration: PageDecoration(
            titleTextStyle: TextStyles.h3.copyWith(color: ColorsManager.blue),
            bodyTextStyle: TextStyles.subtle,
          ),
        ),
        PageViewModel(
          title: "Take the Next Step",
          body:
              "Pathway recommends hackathons and competitions to challenge your skills. Learn, collaborate, and grow—all in one place. Start your journey today!",
          image: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Image.asset("assets/images/onboarding_3.png", width: 350),
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyles.h3.copyWith(color: ColorsManager.blue),
            bodyTextStyle: TextStyles.subtle,
          ),
        ),
      ],
      onDone: () {
        context.pushNamed(Routes.signIn);
      },
      onSkip: () {
        context.pushNamed(Routes.signIn);
      },
      showSkipButton: true,
      skip: Text(
        'Skip',
        style: TextStyles.p.copyWith(color: ColorsManager.vibrantPink),
      ),
      next: Icon(
        Icons.arrow_forward,
        size: 25,
        color: ColorsManager.vibrantPink,
      ),
      done: Text(
        'Done',
        style: TextStyles.p.copyWith(color: ColorsManager.vibrantPink),
      ),
      dotsDecorator: DotsDecorator(
        color: ColorsManager.softPink,
        activeColor: ColorsManager.vibrantPink,
        size: Size(10.0, 10.0),
        activeSize: Size(15.0, 10.0),
      ),
    );
  }
}
