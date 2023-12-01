import 'package:http/http.dart' as http;

class UserNetwork {
  Future<http.Response> fetchUser() async {
    return await http.get(Uri.parse(
        "https://geektrust.s3-ap-southeast-1.amazonaws.com/adminui-problem/members.json"));
  }
}
