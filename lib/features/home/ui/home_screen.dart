import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_template/core/helpers/spacing.dart';
import 'package:my_template/core/helpers/toasts.dart';
import 'package:my_template/core/routing/extensions.dart';
import 'package:my_template/core/routing/routes.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/features/home/logic/cubit/home_cubit.dart';
import 'package:my_template/features/home/logic/cubit/home_state.dart';
import 'package:my_template/features/home/ui/widgets/my_timeline_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, List<String>> data = {
    "HTML": ["CSS", "JavaScript", "Responsive Design", "Frontend Development Projects"],
    "CSS": ["Sass", "Flexbox", "Grid", "Design Systems"],
    "JavaScript": ["ES6+ Features", "ReactJS", "Node.js", "Backend Development Projects"],
    "Project": ["Express.js", "MongoDB", "REST APIs", "Backend Development Projects"],
    "ReactJS": ["Redux", "Material UI", "GraphQL", "Real-world Projects"],
    "Node.js": ["Express.js", "MongoDB", "REST APIs", "Backend Development Projects"],
  };

  @override
  void initState() {
    super.initState();
    if (context.read<HomeCubit>().roadMap.isEmpty) {
      context.read<HomeCubit>().getRoadMap();
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<String> keys = data.keys.toList();

    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetUserError) {
            errorToast(state.message).show(context);
          }
          if (state is GetRoadMapError) {
            errorToast(state.message).show(context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Discover Your Roadmap',
                      textAlign: TextAlign.center,
                      style: TextStyles.h2.copyWith(color: ColorsManager.blue),
                    ),
                    state is GetRoadMapLoading
                        ? LoadingView()
                        : state is! GetRoadMapError
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cubit.roadMap.length,
                                itemBuilder: (context, index) {
                                  String title = cubit.roadMap.keys.toList()[index];
                                  List<String> contents = cubit.roadMap[title]!;
                                  bool isPast = index < context.read<HomeCubit>().completedSteps;
                                  bool isFirst = index == 0;
                                  bool isLast = index == cubit.roadMap.length - 1;

                                  return MyTimelineTile(
                                    isFirst: isFirst,
                                    isLast: isLast,
                                    isPast: isPast,
                                    eventCard: title == "project"
                                        ? Row(
                                            children: [
                                              Text(
                                                title,
                                                style: TextStyles.text1.copyWith(color: ColorsManager.blue),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  context.pushNamed(Routes.projectView);
                                                },
                                                icon: const Icon(Icons.arrow_forward_ios_outlined),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      title,
                                                      style: TextStyles.text1.copyWith(color: ColorsManager.blue),
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      context.pushNamed(Routes.fieldDescription, arguments: title);
                                                      // showModalBottomSheet(
                                                      //   backgroundColor:
                                                      //       ColorsManager.white, // Set background to transparent
                                                      //   shape: RoundedRectangleBorder(
                                                      //     borderRadius: BorderRadius.only(
                                                      //       topLeft: Radius.circular(14.0), // Adjust top-left radius
                                                      //       topRight: Radius.circular(14.0), // Adjust top-right radius
                                                      //     ),
                                                      //   ),
                                                      //   context: context,
                                                      //   builder: (context) {
                                                      //     // return MyBottomDrawer(
                                                      //     //   fieldDescription: cubit.fieldDescription,
                                                      //     // );
                                                      //     return SizedBox();
                                                      //   },
                                                      // );
                                                    },
                                                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                                                  ),
                                                ],
                                              ),
                                              ...contents.map((item) => Text(
                                                    "• $item",
                                                    style: TextStyles.small.copyWith(color: ColorsManager.blue),
                                                  )),
                                              const SizedBox(height: 8),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    color: ColorsManager.vibrantPink,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      context.pushNamed(Routes.quizView);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'Start Quiz',
                                                        style: TextStyles.small.copyWith(color: ColorsManager.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  );
                                },
                              )
                            : Center(
                                child: Text('No data'),
                              ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        verticalSpace(200),
        Lottie.asset('assets/animations/loading.json'),
      ],
    );
  }
}

// class MyBottomDrawer extends StatelessWidget {
//   final FieldDescription fieldDescription; // Pass the field ID to fetch the description

//   const MyBottomDrawer({
//     super.key,
//     required this.fieldDescription,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               'Description:',
//               style: TextStyles.p.copyWith(color: ColorsManager.blue),
//             ),
//           ),
//           verticalSpace(12.h),
//           Text(
//             fieldDescription.description,
//             style: TextStyles.small,
//           ),
//           verticalSpace(12.h),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               'Resources:',
//               style: TextStyles.p.copyWith(color: ColorsManager.blue),
//             ),
//           ),
//           verticalSpace(12.h),
//           ListView.builder(
//             padding: EdgeInsets.zero,
//             shrinkWrap: true,
//             itemCount: fieldDescription.resources.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(
//                   fieldDescription.resources[index],
//                   style: TextStyles.small.copyWith(color: ColorsManager.blue),
//                 ),
//                 leading: const Icon(Icons.link),
//                 onTap: () {
//                   print('Opening ${fieldDescription.resources[index]}');
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
