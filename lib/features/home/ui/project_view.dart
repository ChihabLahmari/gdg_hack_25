import 'package:flutter/material.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/routing/extensions.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/features/auth/data/models/suggested_user.dart';
import 'package:my_template/features/home/ui/network_screen.dart';

class ProjectView extends StatelessWidget {
  ProjectView({super.key});

  final users = generateTestUsers(); // Generate 5 test users

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
          'Project Details',
          style: TextStyles.h4.copyWith(color: ColorsManager.blue),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'NextGen Frontend Framework',
                  style: TextStyles.h4,
                ),
              ),
              verticalSpace(8),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'A modern, lightweight frontend framework thatsimplifies UI development with pre-built  components and improved performance.',
                  style: TextStyles.p,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace(12),
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    color: ColorsManager.darkPurple,
                  ),
                  horizontalSpace(8),
                  Text(
                    'Team Members :',
                    style: TextStyles.text1.copyWith(color: ColorsManager.darkPurple),
                  ),
                ],
              ),
              verticalSpace(12),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return MyUserListTile(user: user);
                },
              ),
              verticalSpace(12),
              Row(
                children: [
                  Icon(
                    Icons.school_outlined,
                    color: ColorsManager.darkPurple,
                  ),
                  horizontalSpace(8),
                  Text(
                    'Mentor :',
                    style: TextStyles.text1.copyWith(color: ColorsManager.darkPurple),
                  ),
                ],
              ),
              verticalSpace(12),
              MyUserListTile(
                user: SuggestedUser(
                  username: 'Mark kal',
                  skills: 'Flutter, Dart, Firebase',
                  profileImg: 'https://randomuser.me/api/portraits/men/11.jpg',
                  score: 23,
                ),
              ),
              verticalSpace(12),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: ColorsManager.darkPurple,
                  ),
                  horizontalSpace(8),
                  Text(
                    'Duration :',
                    style: TextStyles.text1.copyWith(color: ColorsManager.darkPurple),
                  ),
                ],
              ),
              verticalSpace(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Start:11/02/2025", style: TextStyles.small),
                  SizedBox(width: 10), // Space between
                  Text("|", style: TextStyles.small), // Separator
                  SizedBox(width: 10), // Space between
                  Text("End: 23/02/2025", style: TextStyles.small),
                ],
              ),
              verticalSpace(12),
              Row(
                children: [
                  Icon(
                    Icons.link,
                    color: ColorsManager.darkPurple,
                  ),
                  horizontalSpace(8),
                  Text(
                    'Resources & Links:',
                    style: TextStyles.text1.copyWith(color: ColorsManager.darkPurple),
                  ),
                ],
              ),
              verticalSpace(12),
              Align(
                alignment: Alignment.centerLeft,
                child: ProjectResources(),
              ),
              verticalSpace(25),
            ],
          ),
        ),
      ),
    );
  }
}

List<SuggestedUser> generateTestUsers() {
  return [
    SuggestedUser(
      username: 'john_doe',
      skills: 'Flutter, Dart, Firebase',
      profileImg: 'https://randomuser.me/api/portraits/men/1.jpg',
      score: 234,
    ),
    SuggestedUser(
      username: 'jane_smith',
      skills: 'React, Node.js, MongoDB',
      profileImg: 'https://randomuser.me/api/portraits/women/2.jpg',
      score: 123,
    ),
    SuggestedUser(
      username: 'alex_johnson',
      skills: 'Java, Spring Boot, MySQL',
      profileImg: 'https://randomuser.me/api/portraits/men/3.jpg',
      score: 345,
    ),
    SuggestedUser(
      score: 234,
      username: 'emma_white',
      skills: 'Python, Django, PostgreSQL',
      profileImg: 'https://randomuser.me/api/portraits/women/4.jpg',
    ),
    SuggestedUser(
      username: 'michael_green',
      skills: 'Java, Flutter, MySQL',
      profileImg: 'https://randomuser.me/api/portraits/men/5.jpg',
      score: 21,
    ),
    SuggestedUser(
      username: 'michael_green',
      skills: 'Java, Flutter, MySQL',
      profileImg: 'https://randomuser.me/api/portraits/men/6.jpg',
      score: 20,
    ),
  ];
}

class ProjectResources extends StatelessWidget {
  final Map<String, String> resources = {
    "GitHub": "https://github.com/frontend-nextgen",
    "Docs": "https://docs.nextgen-ui.com",
    "UI Design": "https://figma.com/frontend-ui",
    "Live Demo": "https://nextgen-ui.com/demo",
  };

  ProjectResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: resources.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: GestureDetector(
            onTap: () {},
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: "${entry.key}:  ",
                    style: TextStyles.small,
                  ),
                  TextSpan(
                    text: entry.value.replaceAll("https://", ""), // Show clean link
                    style: TextStyles.small.copyWith(color: ColorsManager.blue, decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
