import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_template/core/helpers/app_regex.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/routing/extensions.dart';
import 'package:my_template/core/routing/routes.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/core/widgets/my_text_button.dart';
import 'package:my_template/core/widgets/my_text_form_field.dart';
import 'package:my_template/features/auth/logic/register_cubit/cubit.dart';
import 'package:my_template/features/auth/logic/register_cubit/state.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              'Welcome to GDG SkillTree!',
              style: TextStyles.h4,
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyles.h2.copyWith(color: ColorsManager.blue),
                      ),
                      verticalSpace(14),
                      ProfileAvatar(),
                      verticalSpace(14),
                      MyTextFormField(
                        controller: cubit.fullNameController,
                        labelText: 'Full name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Full name is required';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(14),
                      MyTextFormField(
                        controller: cubit.userNameController,
                        labelText: 'User name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'User name is required';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(14),
                      MyTextFormField(
                        controller: cubit.emailController,
                        labelText: 'Email Address',
                        validator: (value) {
                          if (value!.isEmpty || !AppRegex.isEmailValid(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(14),
                      MyTextFormField(
                        controller: cubit.passwordController,
                        labelText: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        isPassword: true,
                      ),
                      verticalSpace(14),
                      MyTextFormField(
                        controller: cubit.confirmPasswordController,
                        labelText: 'Confirm Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != cubit.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        isPassword: true,
                      ),
                      verticalSpace(30),
                      MyTextButton(
                        buttonText: 'Continue',
                        textStyle: TextStyles.h4.copyWith(color: ColorsManager.white),
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            context.pushNamed(Routes.selectSkillsAndImage);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _image; // Store the selected image
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Convert image to Base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);

      setState(() {
        _image = imageFile;
        context.read<RegisterCubit>().base64Image = base64String;
        print("✅ Image picked: $base64String");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight, // Position camera icon
      children: [
        GestureDetector(
          onTap: _pickImage, // Tap on image to pick a new one
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            backgroundImage: _image != null
                ? FileImage(_image!) as ImageProvider
                : AssetImage('assets/images/person.png'), // Default image
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: _pickImage, // Tap camera icon to pick an image
            child: CircleAvatar(
              radius: 18,
              backgroundColor: ColorsManager.vibrantPink, // Change as needed
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
