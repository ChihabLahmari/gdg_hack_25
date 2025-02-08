import 'package:flutter/material.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/profile_rectangle.png'),
        Padding(
          padding: const EdgeInsets.only(top: 50.0).copyWith(left: 24, right: 24),
          child: Row(
            children: [
              Icon(Icons.notifications_outlined),
              Spacer(),
              Icon(Icons.more_vert_outlined),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 180.0).copyWith(left: 24, right: 24),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(
                      'https://t4.ftcdn.net/jpg/05/50/45/65/360_F_550456541_mMBkyPx1G6XtqPYrT8mG12O8Uz5XBTCZ.jpg'),
                ),
                verticalSpace(10),
                Text(
                  'John Doe',
                  style: TextStyles.p,
                ),
                Text(
                  'Frontend Developer (React)',
                  style: TextStyles.small.copyWith(color: ColorsManager.gray),
                ),
                Text(
                  'John@gmail.com | +123456789',
                  style: TextStyles.p,
                ),
                verticalSpace(10),
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: ColorsManager.anotherBlue,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.newspaper),
                        title: Text(
                          'Edit Profile Information',
                          style: TextStyles.small,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text(
                          'Notifications',
                          style: TextStyles.small,
                        ),
                        trailing: Text(
                          'ON',
                          style: TextStyles.small.copyWith(color: ColorsManager.blue),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.language),
                        title: Text(
                          'Language',
                          style: TextStyles.small,
                        ),
                        trailing: Text(
                          'English',
                          style: TextStyles.small.copyWith(color: ColorsManager.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(10),
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: ColorsManager.anotherBlue,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.security),
                        title: Text(
                          'Security',
                          style: TextStyles.small,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.design_services),
                        title: Text(
                          'Theme',
                          style: TextStyles.small,
                        ),
                        trailing: Text(
                          'Light mode',
                          style: TextStyles.small.copyWith(color: ColorsManager.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(10),
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: ColorsManager.anotherBlue,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.support),
                        title: Text(
                          'Help & Support',
                          style: TextStyles.small,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.message),
                        title: Text(
                          'Contact us',
                          style: TextStyles.small,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
