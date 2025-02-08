import 'package:my_template/features/auth/data/models/suggested_user.dart';
import 'package:my_template/features/auth/data/models/user.dart';
import 'package:my_template/features/home/data/models/filed_desc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetRoadMapLoading extends HomeState {}

class GetRoadMapSuccess extends HomeState {}

class GetRoadMapError extends HomeState {
  final String message;

  GetRoadMapError(this.message);
}

class GetUserLoading extends HomeState {}

class GetUserError extends HomeState {
  final String message;

  GetUserError(this.message);
}

class GetSimilarUsersLoading extends HomeState {}

class GetSimilarUsersSuccess extends HomeState {
  final List<SuggestedUser> users;

  GetSimilarUsersSuccess(this.users);
}

class GetSimilarUsersError extends HomeState {
  final String message;

  GetSimilarUsersError(this.message);
}

class GetFieldDescLoading extends HomeState {}

class GetFieldDescSuccess extends HomeState {
  final FieldDescription fieldDescription;

  GetFieldDescSuccess(this.fieldDescription);
}

class GetFieldDescError extends HomeState {
  final String message;

  GetFieldDescError(this.message);
}


class CompletedStepsUpdated extends HomeState {

}