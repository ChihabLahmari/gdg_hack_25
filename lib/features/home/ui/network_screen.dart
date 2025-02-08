import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/routing/extensions.dart';
import 'package:my_template/core/routing/routes.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/features/auth/data/models/suggested_user.dart';
import 'package:my_template/features/home/logic/cubit/home_cubit.dart';
import 'package:my_template/features/home/logic/cubit/home_state.dart';
import 'package:my_template/features/home/ui/home_screen.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  @override
  void initState() {
    super.initState();
    if (context.read<HomeCubit>().similarUsers.isEmpty) {
      context.read<HomeCubit>().getSimilarUsers();
    }
  }

  final users = generateTestUsers();
  // Generate 5 test users
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetSimilarUsersError) {
          // errorToast(state.message).show(context);
        }

        if (state is GetSimilarUsersSuccess) {
          context.read<HomeCubit>().similarUsers = state.users;
        }
      },
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: state is GetSimilarUsersLoading
                ? LoadingView()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        verticalSpace(40.h),
                        Text(
                          'Expand Your Network',
                          style: TextStyles.h2.copyWith(color: ColorsManager.blue),
                        ),
                        verticalSpace(10.h),
                        Text(
                          'Connect, Learn, and Grow with Your Community',
                          style: TextStyles.blockquote,
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(10.h),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.similarUsers.isEmpty ? users.length : cubit.similarUsers.length,
                          itemBuilder: (context, index) {
                            SuggestedUser user = cubit.similarUsers.isEmpty ? users[index] : cubit.similarUsers[index];
                            return MyUserListTile(user: user);
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class MyUserListTile extends StatelessWidget {
  const MyUserListTile({
    super.key,
    required this.user,
  });

  final SuggestedUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsManager.gray, // Border color
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () => context.pushNamed(Routes.userProfile, arguments: user),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.profileImg),
          radius: 24,
        ),
        title: Text(
          user.username,
          style: TextStyles.p,
        ),
        subtitle: Text(
          user.skills,
          style: TextStyles.small,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: ColorsManager.blue,
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
