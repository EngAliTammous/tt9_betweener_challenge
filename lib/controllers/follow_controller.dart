
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/follow.dart';
import '../models/user.dart';


Future<Follow> getFollowingFollowers () async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  print('Follow : ${response.statusCode}');
  //print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    //print(response.body);
    return Follow.fromJson(jsonDecode(response.body));

    // return data ;
  }

  return Future.error('Follow Error');


}

Future<bool> addFollow(int followId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final headers = {
    'Authorization': 'Bearer ${user.token}',
    'Content-Type': 'application/x-www-form-urlencoded',
  };
// jsonEncode: used to convert Dart objects (usually maps or lists) into a JSON-encoded string
  print(followId);
  final body = {
    'followee_id': followId.toString(),
  };

  final response = await http.post(Uri.parse(followUrl), headers: headers, body: body);
   print('add Follow ${response.statusCode}');
  if (response.statusCode == 200) {
        return true ;
  } else {
    print('Failed to add link. Status code: ${response.statusCode}');
    //print('Response body: ${response.body}');
    return false;
  }
}
