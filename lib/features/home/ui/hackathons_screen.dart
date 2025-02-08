import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/features/home/data/models/hackathon.dart';

class HackathonsPage extends StatelessWidget {
  HackathonsPage({super.key});

  final hackathons = generateTestHackathons(); // Generate 5 test hackathons

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpace(40.h),
              Text(
                'Hack, Build, Win!',
                style: TextStyles.h2.copyWith(color: ColorsManager.blue),
              ),
              verticalSpace(10.h),
              Text(
                'Compete, Create & Conquer!',
                style: TextStyles.blockquote,
                textAlign: TextAlign.center,
              ),
              verticalSpace(20.h),
              // Hackathon List
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: hackathons.length,
                itemBuilder: (context, index) {
                  final hackathon = hackathons[index];
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
                      leading: Image.asset(
                        'assets/images/flash.png',
                      ),
                      title: Text(
                        hackathon.name,
                        style: TextStyles.p,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hackathon.club,
                            style: TextStyles.small.copyWith(color: ColorsManager.black),
                          ),
                          Text(
                            'Skills: ${hackathon.skillsRequired.join(', ')}',
                            style: TextStyles.small.copyWith(color: ColorsManager.gray),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: ColorsManager.black,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Hackathon> generateTestHackathons() {
  return [
    Hackathon(
      name: 'Web Wizards Hackathon',
      club: 'Tech Club',
      skillsRequired: ['Flutter', 'Dart', 'Firebase'],
      level: 'Intermediate',
      startDate: '2025-03-01',
      endDate: '2025-03-03',
    ),
    Hackathon(
      name: 'SS Battle Royale',
      club: 'AI Club',
      skillsRequired: ['Python', 'Machine Learning', 'TensorFlow'],
      level: 'Advanced',
      startDate: '2025-04-05',
      endDate: '2025-04-07',
    ),
    Hackathon(
      name: 'Speed Coding Jam',
      club: 'Frontend Club',
      skillsRequired: ['JavaScript', 'React', 'CSS'],
      level: 'Beginner',
      startDate: '2025-05-10',
      endDate: '2025-05-12',
    ),
    Hackathon(
      name: 'AI-Powered UI Challenge',
      club: 'Mobile Dev Club',
      skillsRequired: ['Java', 'Kotlin', 'Android'],
      level: 'Intermediate',
      startDate: '2025-06-15',
      endDate: '2025-06-17',
    ),
    Hackathon(
      name: 'Web Animation Hack',
      club: 'Cybersecurity Club',
      skillsRequired: ['Ethical Hacking', 'C', 'Linux'],
      level: 'Advanced',
      startDate: '2025-07-01',
      endDate: '2025-07-03',
    ),
    Hackathon(
      name: 'E-Commerce UI Sprint',
      club: 'Cybersecurity Club',
      skillsRequired: ['Ethical Hacking', 'C', 'Linux'],
      level: 'Advanced',
      startDate: '2025-07-01',
      endDate: '2025-07-03',
    ),
  ];
}
