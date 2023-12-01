import 'dart:convert';

import 'package:admin/models.dart';
import 'package:admin/network/user.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final UserNetwork _userNetwork = UserNetwork();
  Future<Either<List<User>, bool>> fetchUser() async {
    http.Response response = await _userNetwork.fetchUser();

    if (response.statusCode == 200) {
      List<User> users = [];
      List<dynamic> userJson = jsonDecode(response.body);
      for (var element in userJson) {
        users.add(User.fromJson(element));
      }
      return left(users);
    }
    return right(false);
  }
}
