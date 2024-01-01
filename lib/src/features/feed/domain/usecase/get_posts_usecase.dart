import 'package:insta/src/features/feed/domain/repository/post_repository.dart';
import 'package:insta/src/shared/domain/entities/post.dart';
import 'package:insta/src/shared/domain/usecase/usecases.dart';

class GetPostsUsecase implements UseCase<List<Post>, NoParams> {
  final PostRepository postRepository;

  GetPostsUsecase({required this.postRepository});
  @override
  Future<List<Post>> call(NoParams params) async {
    return postRepository.getPosts();
  }
}
