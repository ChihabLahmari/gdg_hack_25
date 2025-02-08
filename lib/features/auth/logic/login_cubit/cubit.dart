import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/core/di/dependency_injection.dart';
import 'package:my_template/core/helpers/shared_prefrences.dart';
import 'package:my_template/core/networking/api_service.dart';
import 'package:my_template/features/auth/data/models/login_request_body.dart';
import 'package:my_template/features/auth/data/repos/login_repo.dart';
import 'package:my_template/features/auth/logic/login_cubit/state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit get(context) => BlocProvider.of(context);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LocalStorageService localStorageService = getIt.get<LocalStorageService>();

  final formKey = GlobalKey<FormState>();

  AuthRepo loginRepo = AuthRepo(ApiService());

  void signIn() async {
    emit(SignInLoading());

    var data = await loginRepo.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    data.fold(
      (l) {
        emit(SignInFailure(l.message ?? 'An error occurred'));
      },
      (user) async {
        await localStorageService.saveUser(user);
        emit(SignInSuccess());
      },
    );
  }
}
