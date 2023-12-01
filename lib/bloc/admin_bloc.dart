import 'package:admin/models.dart';
import 'package:admin/repository/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin/bloc/admin_events.dart';
import 'package:admin/bloc/admin_states.dart';

class FetchUsersBloc extends Bloc<FetchUsersEvent, FetchUsersState> {
  FetchUsersBloc() : super(FetchUsersInitial()) {
    on<GetUserEvents>(getUser);
  }
}

Future getUser(FetchUsersEvent event, Emitter<FetchUsersState> emitter) async {
  emitter(FetchUserLoading());
  print("ekkhk");

  final UserRepository userRepository = UserRepository();

  final result = await userRepository.fetchUser();

  if (result is Left) {
    List<User> users = result.fold((l) => l, (r) => []);
    emitter(FetchUserSuccess(users));
  } else {
    emitter(FetchUserError());
  }
}
