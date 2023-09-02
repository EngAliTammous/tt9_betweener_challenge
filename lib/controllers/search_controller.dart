

import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

Future<List<UserClass>> searchController(Map<String, dynamic> body) async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  User user = userFromJson(sharedPreferences.getString('user')!);
  final response = await http.post(
    Uri.parse(apiUrlSearch),
    body: body,
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
  List<UserClass> listOfUsers = [];

  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    for(dynamic u in responseJson['user']){
      listOfUsers.add(UserClass.fromJson(u));
    }
    return listOfUsers;// convert from json to dart object
  } else {
    throw Exception('Failed to search');
  }
}
