import '../../../../shared/domain/entities/user.dart';

class LoggedInUser extends User {
  final String? email;
  const LoggedInUser({
    required super.id,
    required super.username,
    super.followers,
    super.imagePath,
    super.followings,
    this.email,
  });

  static const empty = LoggedInUser(id: '_', username: '-', email: '-');
  @override
  List<Object?> get props => [
        id,
        username,
        followers,
        followings,
        imagePath,
        email,
      ];

  LoggedInUser copyWith({
    String? id,
    String? username,
    int? followers,
    int? followings,
    String? imagePath,
    String? email,
  }) {
    return LoggedInUser(
      id: id ?? this.id,
      username: username ?? this.username,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      imagePath: imagePath ?? this.imagePath,
      email: email ?? this.email,
    );
  }
}
