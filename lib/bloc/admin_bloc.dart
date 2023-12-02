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
    on<DeleteSelectedUserEvent>(deleteUser);
    on<SearchUserEvent>(searchUser);
  }
}

Future getUser(FetchUsersEvent event, Emitter<FetchUsersState> emitter) async {
  emitter(FetchUserLoading());
  if (kDebugMode) {
    print("ekkhk");
  }

  final UserRepository userRepository = UserRepository();

  final result = await userRepository.fetchUser();

  if (result is Left) {
    List<User> users = result.fold((l) => l, (r) => []);
    emitter(FetchUserSuccess(users));
  } else {
    emitter(FetchUserError());
  }
}

Future deleteUser(
    DeleteSelectedUserEvent event, Emitter<FetchUsersState> emitter) async {
  emitter(DeleteSelectedUserLoadingState());

  List<User> listCurrentlly = event.listToShow;
  List<User> listToDelete = event.listToDelete;

  final List<User> listAfterDelete = listCurrentlly
      .where((element) => !listToDelete.contains(element))
      .toList();

  emitter(DeleteSelectedUserSuccessState(listAfterDelete));
}

Future searchUser(
    SearchUserEvent event, Emitter<FetchUsersState> emitter) async {
  List<User> listCurrentlly = event.currentList;
  String query = event.query;

  final List<User> listAfterSearch = [];

  for (var i = 0; i < listCurrentlly.length; i++) {
    if (listCurrentlly[i].name!.toLowerCase().contains(query.toLowerCase()) ||
        listCurrentlly[i].email!.toLowerCase().contains(query.toLowerCase()) ||
        listCurrentlly[i].role!.toLowerCase().contains(query.toLowerCase())) {
      listAfterSearch.add(listCurrentlly[i]);
    }
  }

  emitter(SearchQueryState(listAfterSearch));
}
