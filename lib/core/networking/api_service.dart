import 'package:dio/dio.dart';
import 'package:my_template/core/di/dependency_injection.dart';
import 'package:my_template/core/helpers/shared_prefrences.dart';
import 'package:my_template/core/networking/api_constants.dart';
import 'package:my_template/core/networking/api_error_model.dart';
import 'package:my_template/features/auth/data/models/login_request_body.dart';
import 'package:my_template/features/auth/data/models/register_request_body.dart';
import 'package:my_template/features/auth/data/models/suggested_user.dart';
import 'package:my_template/features/auth/data/models/user.dart';
import 'package:my_template/features/home/data/models/filed_desc.dart';
import 'package:my_template/features/home/data/models/get_road_map.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 1000),
      receiveTimeout: const Duration(seconds: 1000),
    ),
  );

  LocalStorageService localStorageService = getIt.get<LocalStorageService>();

  ApiService() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  Future<User> login(LoginRequestBody loginRequestBody) async {
    try {
      Response response = await _dio.post(
        "auth/login",
        data: loginRequestBody.toJson(),
      );
      print('✅ Response : ${response.headers}');
      User user = User.fromJson(response.data);

      var jwtCookie = extractJwtToken(response.headers.toString());
      print('✅  Token: $jwtCookie');
      await localStorageService.saveToken(jwtCookie ?? 'token');

      return user;
    } catch (e) {
      if (e is DioException) {
        print("Login Error: ${e.response?.data ?? e.message}");
      } else {
        print("Unexpected Error: $e");
      }
      rethrow;
    }
  }

  Future<User> register(RegisterRequestBody registerRequestBody) async {
    try {
      print('✅ RegisterRequestBody : $registerRequestBody');

      Response response = await _dio.post(
        "auth/signup",
        data: registerRequestBody.toJson(),
      );
      print('✅ Register Request Body : ${response.data}');
      User user = User.fromJson(response.data);

      return user;
    } catch (e) {
      if (e is DioException) {
        print("🔥 Login Error: ${e.response?.data ?? e.message}");
      } else {
        print("🔥 Unexpected Error: $e");
      }
      rethrow;
    }
  }

  Future<GetRoadMapResponse> getRoadMap() async {
    try {
      String token = await localStorageService.getToken() ?? 'token';
      Response response = await _dio.get(
        "/user/roadmap",
        options: Options(headers: {
          "Cookie": "jwt=$token",
        }),
      );

      print('✅ Roadmap Response : ${response.data}');
      return GetRoadMapResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("❌ DioException: ${e.response?.statusCode} - ${e.response?.data ?? e.message}");

      // Return a consistent error model instead of throwing
      throw ApiErrorModel(
        message: e.response?.data["message"] ?? "Server error",
        error: e.response?.data["error"] ?? e.message,
      );
    } catch (e) {
      print("❌ Unexpected Error: $e");
      throw ApiErrorModel(
        message: "Unexpected error occurred",
        error: e.toString(),
      );
    }
  }

  Future<List<SuggestedUser>> getSimilarUsers() async {
    try {
      String token = await localStorageService.getToken() ?? 'token';
      Response response = await _dio.get(
        "/similar-users",
        options: Options(headers: {
          "Cookie": "jwt=$token",
        }),
      );

      print('✅ similar-users Response : ${response.data}');
      List<SuggestedUser> users = (response.data as List).map((userJson) => SuggestedUser.fromJson(userJson)).toList();
      return users;
      // return users;
    } on DioException catch (e) {
      print("❌ DioException: ${e.response?.statusCode} - ${e.response?.data ?? e.message}");

      // Return a consistent error model instead of throwing
      throw ApiErrorModel(
        message: e.response?.data["message"] ?? "Server error",
        error: e.response?.data["error"] ?? e.message,
      );
    } catch (e) {
      print("❌ Unexpected Error: $e");
      throw ApiErrorModel(
        message: "Unexpected error occurred",
        error: e.toString(),
      );
    }
  }

  Future<FieldDescription> getFieldDescription(String fieldName) async {
    try {
      String token = await localStorageService.getToken() ?? 'token';
      Response response = await _dio.get(
        "user/resources/",
        data: {
          'field': fieldName,
        },
        options: Options(headers: {
          "Cookie": "jwt=$token",
        }),
      );
      print('✅ Response : ${response.headers}');
      FieldDescription fieldDescription = FieldDescription.fromJson(response.data);

      return fieldDescription;
    } catch (e) {
      if (e is DioException) {
        print("Login Error: ${e.response?.data ?? e.message}");
      } else {
        print("Unexpected Error: $e");
      }
      rethrow;
    }
  }
}

String? extractJwtToken(String headersString) {
  List<String> lines = headersString.split('\n');

  for (String line in lines) {
    if (line.startsWith("set-cookie:")) {
      List<String> cookies = line.substring(11).split(';'); // Remove "set-cookie:" and split by ";"
      for (String cookie in cookies) {
        cookie = cookie.trim();
        if (cookie.startsWith("jwt=")) {
          return cookie.substring(4); // Remove "jwt="
        }
      }
    }
  }

  return null; // Return null if no token is found
}
