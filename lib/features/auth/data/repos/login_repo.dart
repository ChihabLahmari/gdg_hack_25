import 'package:dartz/dartz.dart';
import 'package:my_template/core/networking/api_error_model.dart';
import 'package:my_template/features/auth/data/models/login_request_body.dart';
import 'package:my_template/features/auth/data/models/register_request_body.dart';
import 'package:my_template/features/auth/data/models/user.dart';

import '../../../../core/networking/api_service.dart';

class AuthRepo {
  final ApiService _apiService;

  AuthRepo(this._apiService);

  Future<Either<ApiErrorModel, User>> login(LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return right(response);
    } catch (error) {
      return left(ApiErrorModel(message: error.toString()));
    }
  }

  Future<Either<ApiErrorModel, User>> register(RegisterRequestBody registerRequestBody) async {
    try {
      final response = await _apiService.register(registerRequestBody);
      return right(response);
    } catch (error) {
      return left(ApiErrorModel(message: error.toString()));
    }
  }
}
