import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/core/theming/styles.dart';
import 'package:my_template/features/home/logic/cubit/home_cubit.dart';
import 'package:my_template/features/home/logic/cubit/home_state.dart';

class FieldDescriptionView extends StatelessWidget {
  const FieldDescriptionView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // Trigger Cubit to get the field description when drawer opens
    BlocProvider.of<HomeCubit>(context).getFieldDescription(title);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyles.h3.copyWith(color: ColorsManager.blue),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // Loading state while data is being fetched
          if (state is GetFieldDescLoading) {
            return Center(
              child: Lottie.asset('assets/animations/loading.json'),
            );
          }

          // Error state if something went wrong
          if (state is GetFieldDescError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }

          // Success state where data is available
          if (state is GetFieldDescSuccess) {
            final fieldDescription = state.fieldDescription;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Description:',
                        style: TextStyles.h4.copyWith(color: ColorsManager.blue),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      fieldDescription.description,
                      style: TextStyles.p,
                    ),
                    SizedBox(height: 12.0),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Resources:',
                        style: TextStyles.h4.copyWith(color: ColorsManager.blue),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: fieldDescription.resources.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            fieldDescription.resources[index].name,
                            style: TextStyles.small.copyWith(color: ColorsManager.chosen),
                          ),
                          leading: const Icon(Icons.link),
                          onTap: () {
                            print('Opening ${fieldDescription.resources[index].name}');
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox(); // Return empty widget if no relevant state
        },
      ),
    );
  }
}
