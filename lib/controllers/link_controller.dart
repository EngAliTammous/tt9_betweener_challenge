import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';
import '../Helpers/http_method.dart';
import '../models/link.dart';
import 'package:http/http.dart' as http;

Future<List<Link>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  print(response.statusCode);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;
   // print(jsonDecode(response.body)['links']);
    return data.map((e) => Link.fromJson(e)).toList();
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}
Future<Map<String , dynamic>> addNewLink(String token, String title, String link) async {

  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/x-www-form-urlencoded',
  };
// jsonEncode: used to convert Dart objects (usually maps or lists) into a JSON-encoded string
  final body = {
      'title': title,
      'link': link,
  };

  final response = await http.post(Uri.parse(linksUrl), headers: headers, body: body);

  if (response.statusCode == 200) {
    print(response.body);

    final decodedResponse = jsonDecode(response.body);

  return decodedResponse;
  } else {
    print('Failed to add link. Status code: ${response.statusCode}');
    //print('Response body: ${response.body}');
    return Future.value({'error': 'An error occurred'});  }
}


Future<void> deleteLink(int linkId, String token) async {
  try {
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.delete(
      Uri.parse('$linksUrl/$linkId'), // Replace with your delete link API endpoint
      headers: headers,
    );

    if (response.statusCode == 200) {
      // Link deleted successfully

      print('Link deleted: $linkId');
    } else {
      print('Failed to delete link. Status code: ${response.statusCode}');
      throw Exception('Failed to delete link');
    }
  } catch (e) {
    print('Error while deleting link: $e');
    throw e;
  }
}

Future<void> updateLink(int linkId, String token, String newTitle, String newLink) async {
  try {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'title': newTitle,
      'link': newLink,
    });

    final response = await http.put(
      Uri.parse('$linksUrl/$linkId'), // Replace with your update link API endpoint
      headers: headers,
      body: body,
    );
print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      print('Link updated: $linkId');
      print(decodedResponse);
      //return decodedResponse ;
    } else {
      print('Failed to update link. Status code: ${response.statusCode}');
      throw Exception('Failed to update link');
    }
  } catch (e) {
    print('Error while updating link: $e');
   // throw e;
  }
}


