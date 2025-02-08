import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/core/helpers/shared_prefrences.dart';
import 'package:my_template/core/networking/api_service.dart';
import 'package:my_template/features/auth/data/models/register_request_body.dart';
import 'package:my_template/features/auth/data/repos/login_repo.dart';
import 'package:my_template/features/auth/logic/register_cubit/state.dart';
import 'package:my_template/features/auth/ui/select_skills_image.dart';

import '../../../../core/di/dependency_injection.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<String> pickedSkills = [];

  String? pickedGoal;
  String? base64Image;

  AuthRepo authRepo = AuthRepo(ApiService());

  final LocalStorageService localStorageService = getIt.get<LocalStorageService>();
  void registerUser() async {
    emit(RegisterLoading());

    var data = await authRepo.register(
      RegisterRequestBody(
        email: emailController.text,
        fullName: fullNameController.text,
        username: userNameController.text,
        password: passwordController.text,
        skills: pickedSkills,
        goal: pickedGoal ?? '',
        profileImg:
            'https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg?semt=ais_hybrid',
      ),
    );

    data.fold(
      (l) {
        emit(RegisterFailure(l.message ?? 'An error occurred'));
      },
      (user) async {
        await localStorageService.saveUser(user);
        await localStorageService.saveQuestions(questions);
        await localStorageService.saveUserPrefers(userSpecificRecommondationsController.text);
        emit(RegisterSuccess());
      },
    );
  }

  List<Question> questions = [
    Question(
      questionText: "Would you like to focus on theory first or dive straight into practical applications?",
      options: [
        "Focus on Theory First",
        "Dive Straight into Practical Applications",
      ],
      selectedAnswer: "Focus on Theory First",
    ),
    Question(
      questionText: "Are you a Computer Science student?",
      options: [
        "Yes",
        "No",
      ],
      selectedAnswer: "Yes",
    ),
  ];

  TextEditingController userSpecificRecommondationsController = TextEditingController();
}
