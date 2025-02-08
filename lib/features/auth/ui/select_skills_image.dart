import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/helpers/toasts.dart';
import 'package:my_template/core/routing/app_router.dart';
import 'package:my_template/core/routing/extensions.dart';
import 'package:my_template/core/routing/routes.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/core/widgets/my_text_button.dart';
import 'package:my_template/features/auth/logic/register_cubit/cubit.dart';
import 'package:my_template/features/auth/logic/register_cubit/state.dart';

class SelectSkillsAndImageView extends StatefulWidget {
  const SelectSkillsAndImageView({super.key});

  @override
  _SelectSkillsAndImageViewState createState() => _SelectSkillsAndImageViewState();
}

class _SelectSkillsAndImageViewState extends State<SelectSkillsAndImageView> {
  // List of all available tags
  final List<String> _allTags = [
    "Nothing",
    "Linear Algebra",
    "Statistics",
    "Oop",
    "Dsa",
    "OS",
    "Version Control",
    "System Design",
    "UI/UX",
    "Networking Fundamentals",
    "Fundamental Database",
    "Scripting",
    "Python",
    "JavaScript",
    "Java",
    "SQL",
    "Bash/Shell Scripting",
    "Discrete Mathematics",
    "Computer Architecture",
    "Problem-Solving",
    "Cli"
  ];

  final List<String> goals = [
    "Cloud Computing",
    "Cybersecurity",
    "Programming and Scripting",
    "Data Science",
    "DevOps",
    "Artificial Intelligence",
    "Networking",
    "Database Management",
    "IT Project Management",
    "Web Development",
    "Software Engineering",
    "Blockchain Technology",
    "Game Development",
    "Embedded Systems",
    "Robotics"
  ];

  @override
  Widget build(BuildContext context) {
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
          'Skills & Goals',
          style: TextStyles.h4,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                context.pushNamedAndRemoveUntil(Routes.homeScreen,
                    predicate: (route) => false,
                    arguments: HomeScreenParams(
                        questions: context.read<RegisterCubit>().questions,
                        userSpecificRecommondations:
                            context.read<RegisterCubit>().userSpecificRecommondationsController.text));
              }
              if (state is RegisterFailure) {
                errorToast(state.error).show(context);
              }
            },
            builder: (context, state) {
              var cubit = RegisterCubit.get(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10.h),
                  Text(
                    'What skills do you have?',
                    style: TextStyles.p,
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0, // Horizontal space between tags
                    runSpacing: 4.0, // Vertical space between lines
                    children: _allTags.map((tag) {
                      return FilterChip(
                        backgroundColor: ColorsManager.white,
                        label: Text(
                          tag,
                          style: TextStyles.small,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: ColorsManager.chosen,
                            width: 1, // Border width
                          ),
                          borderRadius: BorderRadius.circular(16.0), // Rounded corners
                        ),
                        selected: cubit.pickedSkills.contains(tag),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              cubit.pickedSkills.add(tag); // Add tag to selected set
                            } else {
                              cubit.pickedSkills.remove(tag); // Remove tag from selected set
                            }
                          });
                        },
                        selectedColor: ColorsManager.chosen.withOpacity(0.3),
                        checkmarkColor: ColorsManager.chosen,
                      );
                    }).toList(),
                  ),
                  verticalSpace(20.h),
                  Text(
                    'What’s your dream career?',
                    style: TextStyles.p,
                  ),
                  verticalSpace(10.h),
                  Wrap(
                    spacing: 8.0, // Horizontal space between tags
                    runSpacing: 4.0, // Vertical space between lines
                    children: goals.map((tag) {
                      return FilterChip(
                        backgroundColor: ColorsManager.white,
                        label: Text(
                          tag,
                          style: TextStyles.small,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: ColorsManager.chosen,
                            width: 1, // Border width
                          ),
                          borderRadius: BorderRadius.circular(16.0), // Rounded corners
                        ),
                        selected: cubit.pickedGoal == tag,
                        onSelected: (isSelected) {
                          setState(() {
                            cubit.pickedGoal = isSelected ? tag : null; // Deselect previous and select new
                          });
                        },
                        selectedColor: ColorsManager.chosen.withOpacity(0.3),
                        checkmarkColor: ColorsManager.chosen,
                      );
                    }).toList(),
                  ),
                  verticalSpace(20.h),
                  QuestionsScreen(),
                  Text(
                    'Is there anything specific you’d like to add to your roadmap?',
                    style: TextStyles.p,
                  ),
                  verticalSpace(10.h),
                  TextFormField(
                    controller: cubit.userSpecificRecommondationsController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter any topics, skills, or goals you want to focus on!",
                      hintStyle: TextStyles.subtle.copyWith(color: ColorsManager.gray),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white, // Background color
                      contentPadding: EdgeInsets.all(12), // Inner padding
                    ),
                  ),
                  verticalSpace(20.h),
                  state is RegisterLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: ColorsManager.blue,
                          ),
                        )
                      : MyTextButton(
                          buttonText: 'Start',
                          textStyle: TextStyles.h4.copyWith(color: ColorsManager.white),
                          onPressed: () {
                            if (cubit.pickedSkills.isNotEmpty || cubit.pickedGoal != null) {
                              cubit.registerUser();
                            } else {
                              errorToast('Please select at least one skill and one goal to continue').show(context);
                            }
                          }),
                  verticalSpace(30.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  String? selectedAnswer;

  Question({
    required this.questionText,
    required this.options,
    this.selectedAnswer,
  });

  /// Convert a JSON Map to a Question object
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['questionText'] as String,
      options: List<String>.from(json['options']),
      selectedAnswer: json['selectedAnswer'] as String?,
    );
  }

  /// Convert a Question object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'options': options,
      'selectedAnswer': selectedAnswer,
    };
  }
}

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: context.read<RegisterCubit>().questions.length,
      itemBuilder: (context, index) {
        return _buildQuestionCard(context.read<RegisterCubit>().questions[index]);
      },
    );
  }

  Widget _buildQuestionCard(Question question) {
    return Card(
      color: ColorsManager.white,
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questionText,
            style: TextStyles.p,
          ),
          verticalSpace(5),
          ...question.options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: question.selectedAnswer,
              onChanged: (value) {
                setState(() {
                  question.selectedAnswer = value;
                });
              },
            );
          }),
        ],
      ),
    );
  }
}
