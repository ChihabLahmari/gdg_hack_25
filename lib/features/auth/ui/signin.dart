import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/helpers/toasts.dart';
import 'package:my_template/core/routing/extensions.dart';
import 'package:my_template/core/routing/routes.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/core/widgets/my_text_button.dart';
import 'package:my_template/core/widgets/my_text_form_field.dart';
import 'package:my_template/features/auth/logic/login_cubit/cubit.dart';
import 'package:my_template/features/auth/logic/login_cubit/state.dart';
import 'package:my_template/features/auth/ui/widgets/google_button.dart';
import 'package:my_template/features/auth/ui/widgets/sign_up_text.dart';

import '../../../core/helpers/app_regex.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignInCubit(),
          child: BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              if (state is SignInSuccess) {
                context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (route) => false);
              }
              if (state is SignInFailure) {
                errorToast(state.message).show(context);
              }
            },
            builder: (context, state) {
              var cubit = SignInCubit.get(context);
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome Back to GDG SkillTree!',
                          style: TextStyles.h4,
                        ),
                        verticalSpace(20),
                        Text(
                          'Sign In',
                          style: TextStyles.h2.copyWith(color: ColorsManager.blue),
                        ),
                        verticalSpace(20),
                        MyTextFormField(
                          controller: cubit.emailController,
                          labelText: 'Email Address',
                          validator: (value) {
                            if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
                              return 'Please enter your email address';
                            }
                          },
                        ),
                        verticalSpace(20),
                        MyTextFormField(
                          controller: cubit.passwordController,
                          labelText: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                          },
                          isPassword: true,
                        ),
                        verticalSpace(20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                ColorsManager.lightPurple,
                                ColorsManager.darkPurple,
                                ColorsManager.blue,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyles.p.copyWith(color: Colors.white), // Set to white for the gradient effect
                            ),
                          ),
                        ),
                        verticalSpace(20),
                        state is SignInLoading
                            ? CircularProgressIndicator(
                                color: ColorsManager.blue,
                              )
                            : MyTextButton(
                                buttonText: 'Sign In',
                                textStyle: TextStyles.h4.copyWith(color: ColorsManager.white),
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.signIn();
                                  }
                                },
                              ),
                        verticalSpace(20),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              ColorsManager.lightPurple,
                              ColorsManager.darkPurple,
                              ColorsManager.blue,
                            ],
                          ).createShader(bounds),
                          child: Text(
                            'Or Sign In with',
                            style: TextStyles.h4.copyWith(color: Colors.white), // Set to white for the gradient effect
                          ),
                        ),
                        verticalSpace(20),
                        GoogleButton(
                          onPressed: () {},
                        ),
                        verticalSpace(20),
                        SignupText(onTap: () {
                          context.pushNamed(Routes.signUp);
                        }),
                      ],
                    ),
                  ),
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
