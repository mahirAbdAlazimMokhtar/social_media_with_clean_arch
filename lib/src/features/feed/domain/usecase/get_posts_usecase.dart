import '../repository/post_repository.dart';
import '../../../../shared/domain/entities/post.dart';
import '../../../../shared/domain/usecase/usecases.dart';

class GetPostsUsecase implements UseCase<List<Post>, NoParams> {
  final PostRepository postRepository;

  GetPostsUsecase({required this.postRepository});
  @override
  Future<List<Post>> call(NoParams params) async {
    return postRepository.getPosts();
  }
}
