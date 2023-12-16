import 'package:insta/src/shared/domain/entities/user.dart';

class UserModel {
  final String id;
  final String username;
  final int followers;
  final int followings;
  final String? imagePath;
  const UserModel({
    required this.id,
    required this.username,
    this.followers = 0,
    this.followings = 0,
    this.imagePath,
  });

//factory constructor fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      followers: json['followers'],
      followings: json['followings'],
      imagePath: json['imagePath'],
    );
  }

  // factory constructor fromEntity

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username.value,
      followers: user.followers,
      followings: user.followings,
      imagePath: user.imagePath,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: Username.dirty(username),
      followers: followers,
      followings: followings,
      imagePath: imagePath,
    );
  }
}
