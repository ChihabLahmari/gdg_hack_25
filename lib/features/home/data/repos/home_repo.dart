import 'package:dartz/dartz.dart';
import 'package:my_template/core/networking/api_error_model.dart';
import 'package:my_template/core/networking/api_service.dart';
import 'package:my_template/features/auth/data/models/suggested_user.dart';
import 'package:my_template/features/auth/data/models/user.dart';
import 'package:my_template/features/home/data/models/filed_desc.dart';
import 'package:my_template/features/home/data/models/get_road_map.dart';

class HomeRepo {
  final ApiService _apiService = ApiService();

  HomeRepo();

  Future<Either<ApiErrorModel, GetRoadMapResponse>> getRoadMap() async {
    try {
      final response = await _apiService.getRoadMap();
      return Right(response);
    } catch (e) {
      if (e is ApiErrorModel) {
        return Left(e);
      } else {
        print("❌ Unexpected Repo Error: $e");
        return Left(ApiErrorModel(
          message: "An unexpected error occurred",
          error: e.toString(),
        ));
      }
    }
  }

  Future<Either<ApiErrorModel, List<SuggestedUser>>> getSimilarUsers() async {
    try {
      final response = await _apiService.getSimilarUsers();
      return Right(response);
    } catch (e) {
      if (e is ApiErrorModel) {
        return Left(e);
      } else {
        print("❌ Unexpected Repo Error: $e");
        return Left(ApiErrorModel(
          message: "An unexpected error occurred",
          error: e.toString(),
        ));
      }
    }
  }

  Future<Either<ApiErrorModel, FieldDescription>> getFieldDescription(String fieldName) async {
    try {
      final response = await _apiService.getFieldDescription(fieldName);
      return Right(response);
    } catch (e) {
      if (e is ApiErrorModel) {
        return Left(e);
      } else {
        print("❌ Unexpected Repo Error: $e");
        return Left(ApiErrorModel(
          message: "An unexpected error occurred",
          error: e.toString(),
        ));
      }
    }
  }
}
