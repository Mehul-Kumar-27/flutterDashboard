// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/models.dart';

class FetchUsersEvent {}

class GetUserEvents extends FetchUsersEvent {}

class DeleteSelectedUserEvent extends FetchUsersEvent {
  List<User> listToShow;
  List<User> listToDelete;
  DeleteSelectedUserEvent({
    required this.listToShow,
    required this.listToDelete,
  });
}

class SearchUserEvent extends FetchUsersEvent {
  final String query;
  final List<User> currentList;

  SearchUserEvent(this.query, this.currentList);
}
