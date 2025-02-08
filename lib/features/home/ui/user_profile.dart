import 'package:flutter/material.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/routing/extensions.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/features/auth/data/models/suggested_user.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key, required this.user});

  final SuggestedUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.profileImg),
              ),
              verticalSpace(6),
              Text(user.username, style: TextStyles.p),
              verticalSpace(6),
              Text(user.skills[0], style: TextStyles.p.copyWith(color: Colors.grey)),
              verticalSpace(20),
              Row(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorsManager.vibrantPink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                      child: Center(
                        child: Text(
                          'Connect',
                          style: TextStyles.p.copyWith(color: ColorsManager.white),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorsManager.softPink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                      child: Center(
                        child: Text(
                          'Disconnect',
                          style: TextStyles.p.copyWith(color: ColorsManager.white),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.message_outlined,
                    color: ColorsManager.blue,
                    size: 30,
                  ),
                ],
              ),
              verticalSpace(20),
              CardWidget(
                title: 'Short Bio',
                content: 'Passionate frontend developer with a love for clean UI/UX and performance optimization.',
              ),
              verticalSpace(20),
              CardWidget(
                title: 'Skills & Technologies',
                content: user.skills,
              ),
              verticalSpace(20),
              CardWidget(
                title: 'Hackathon Participation',
                content: 'Frontend Mastery Challenge – 2025',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String content;

  const CardWidget({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.p.copyWith(color: ColorsManager.blue)),
          SizedBox(height: 10),
          Text(content, style: TextStyles.small),
        ],
      ),
    );
  }
}
