import 'package:admin/models.dart';

class FetchUsersState {}

class FetchUsersInitial extends FetchUsersState {}

class FetchUserLoading extends FetchUsersState {}

class FetchUserSuccess extends FetchUsersState {
  final List<User> usersList;

  FetchUserSuccess(this.usersList);
}

class FetchUserError extends FetchUsersState {}
