import 'package:admin/models.dart';

class FetchUsersState {}

class FetchUsersInitial extends FetchUsersState {}

class FetchUserLoading extends FetchUsersState {}

class FetchUserSuccess extends FetchUsersState {
  final List<User> usersList;

  FetchUserSuccess(this.usersList);
}

class FetchUserError extends FetchUsersState {}

class DeleteSelectedUserLoadingState extends FetchUsersState {}

class DeleteSelectedUserSuccessState extends FetchUsersState {
  final List<User> usersList;

  DeleteSelectedUserSuccessState(this.usersList);
}

class DeleteSelectedUserErrorState extends FetchUsersState {
  final String errorMessage;

  DeleteSelectedUserErrorState(this.errorMessage);
}

class SearchQueryState extends FetchUsersState {
  final List<User> usersList;

  SearchQueryState(this.usersList);
}
