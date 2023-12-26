import 'package:equatable/equatable.dart';
import 'package:insta/src/shared/domain/entities/user.dart';

class Post extends Equatable {
  final String id;
  final User user;
  final String caption;
  final String assetPath;

  const Post({
    required this.id,
    required this.user,
    required this.caption,
    required this.assetPath,
  });
  
  @override
 
  List<Object?> get props => [id,user,caption ,assetPath,];
}
