import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/core/di/dependency_injection.dart';
import 'package:my_template/core/helpers/shared_prefrences.dart';
import 'package:my_template/features/auth/data/models/suggested_user.dart';
import 'package:my_template/features/auth/data/models/user.dart';
import 'package:my_template/features/home/data/models/filed_desc.dart';
import 'package:my_template/features/home/data/models/get_road_map.dart';
import 'package:my_template/features/home/data/repos/home_repo.dart';
import 'package:my_template/features/home/logic/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  final HomeRepo _homeRepo = HomeRepo();
  final LocalStorageService _localStorageService = getIt.get<LocalStorageService>();

  User? user;
  Map<String, List<String>> roadMap = {};
  List<SuggestedUser> similarUsers = [];
  FieldDescription? fieldDescription;
  int completedSteps = 0;

  void incrementCompletedSteps() {
    completedSteps++;
    emit(CompletedStepsUpdated());
  }

  Future<void> getUser() async {
    emit(GetUserLoading());
    var user = await _localStorageService.getUser();
    if (user == null) {
      emit(GetUserError('User not found'));
    }
  }

  Future<void> getRoadMap() async {
    print('🚀 GET  Roadmap STARTED');

    emit(GetRoadMapLoading());

    var data = await _homeRepo.getRoadMap();

    data.fold(
      (l) {
        print("❌ Error: ${l.message} | ${l.error}");
        emit(GetRoadMapError(l.message ?? 'An error occurred'));
      },
      (getRoadMapResponse) {
        print('✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅ Success: Roadmap received ${getRoadMapResponse.roadMap.length}');
        roadMap = getRoadMapResponse.addProjectSteps();
        emit(GetRoadMapSuccess());
      },
    );
  }

  Future<void> getSimilarUsers() async {
    print('🚀 GET  Similar users STARTED');

    emit(GetSimilarUsersLoading());

    var data = await _homeRepo.getSimilarUsers();

    data.fold(
      (l) {
        print("❌ Error: ${l.message} | ${l.error}");
        emit(GetSimilarUsersError(l.message ?? 'An error occurred'));
      },
      (users) {
        if (users.isEmpty) {
          print("⚠️ Warning: Received empty roadmap");
          emit(GetSimilarUsersSuccess(users));
        } else {
          print("✅ Success: Roadmap received");
          emit(GetSimilarUsersSuccess(users));
        }
      },
    );
  }

  Future<void> getFieldDescription(String fieldName) async {
    print('🚀 GET  Field Description ');

    emit(GetFieldDescLoading());

    var data = await _homeRepo.getFieldDescription(fieldName);

    data.fold(
      (l) {
        print("❌ Error: ${l.message} | ${l.error}");
        emit(GetFieldDescError(l.message ?? 'An error occurred'));
      },
      (fieldDescription) {
        print("✅ Success: Roadmap received");
        fieldDescription = fieldDescription;
        emit(GetFieldDescSuccess(fieldDescription));
      },
    );
  }
}

extension RoadMapExtension on GetRoadMapResponse {
  Map<String, List<String>> addProjectSteps() {
    final updatedRoadMap = <String, List<String>>{};
    int count = 0;

    roadMap.forEach((key, value) {
      updatedRoadMap[key] = value;
      count++;

      // Insert "project": [] after every 3 keys
      if (count % 3 == 0) {
        updatedRoadMap["project"] = [];
      }
    });

    return updatedRoadMap;
  }
}
