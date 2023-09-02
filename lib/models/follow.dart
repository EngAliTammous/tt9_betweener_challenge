
import 'package:tt9_betweener_challenge/models/user.dart';

class Follow {
  int followingCount;
  int followersCount;
  List<UserClass> following;
  List<UserClass> followers;

  Follow({
    required this.followingCount,
    required this.followersCount,
    required this.following,
    required this.followers,
  });

  factory Follow.fromJson(Map<String, dynamic> json) {
    List<UserClass> followingList = List<UserClass>.from(
      json['following'].map((follower) => UserClass.fromJson(follower)),
    );

    List<UserClass> followersList = List<UserClass>.from(
      json['followers'].map((follower) => UserClass.fromJson(follower)),
    );

    return Follow(
      followingCount: json['following_count'],
      followersCount: json['followers_count'],
      following: followingList,
      followers: followersList,
    );
  }
}
