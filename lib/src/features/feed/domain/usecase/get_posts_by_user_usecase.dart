import 'package:insta/src/features/feed/domain/repository/post_repository.dart';
import 'package:insta/src/shared/domain/entities/post.dart';
import 'package:insta/src/shared/domain/usecase/usecases.dart';

class GetPostsByUserId implements UseCase <List<Post> ,GetPostsByUserParams> {
  final PostRepository postRepository ;

  GetPostsByUserId({required this.postRepository});
   @override
  Future <List<Post>> call(GetPostsByUserParams params)async{
    return postRepository.getPostByUser(params.userId);
  }
}

class GetPostsByUserParams  extends Params {
  final String userId;

  GetPostsByUserParams({required this.userId});

  @override
 
  List<Object?> get props => [userId];
}