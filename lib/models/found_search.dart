
import 'link.dart';

class FoundSearch {
  List<User> user;

  FoundSearch({
    required this.user,
  });

  factory FoundSearch.fromJson(Map<String, dynamic> json) {
    return FoundSearch(
      user: (json['user'] as List<dynamic>)
          .map((userData) => User.fromJson(userData))
          .toList(),
    );
  }
}


class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int isActive;
  dynamic country;
  dynamic ip;
  double? long;
  double? lat;
  List<Link> links;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    this.country,
    this.ip,
    this.long,
    this.lat,
    required this.links,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'country': country,
      'ip': ip,
      'long': long,
      'lat': lat,
      'links': links.map((link) => link.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['emailVerifiedAt'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isActive: json['isActive'],
      country: json['country'],
      ip: json['ip'],
      long: json['long'],
      lat: json['lat'],
      links: (json['links'] as List<dynamic>)
          .map((linkData) => Link.fromJson(linkData))
          .toList(),
    );
  }
}






