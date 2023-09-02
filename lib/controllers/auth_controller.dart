import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

Future<User> login(Map<String, String> body) async {
  final response = await http.post(
    Uri.parse(loginUrl),
    body: body,
  );

  if (response.statusCode == 200) {
    return userFromJson(response.body); // convert from json to dart object
  } else {
    throw Exception('Failed to login');
  }
}

Future<User> register(String name, String email, String password, String conformationPassword) async {
  final response = await http.post(
    Uri.parse(registerUrl),
    body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': conformationPassword,
    },
  );
print(response.statusCode);
  if (response.statusCode == 201) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    return User.fromJson(responseData); // Parse the response data into a User object
  } else {
    throw Exception('Failed to register');
  }
}