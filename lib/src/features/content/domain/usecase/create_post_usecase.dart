import 'package:insta/src/features/feed/domain/repository/post_repository.dart';
import 'package:insta/src/shared/domain/entities/post.dart';
import 'package:insta/src/shared/domain/usecase/usecases.dart';

class CreatePostUsecase implements UseCase<void, CreatePostParams> {
  final PostRepository postRepository;

  CreatePostUsecase({required this.postRepository});
  @override
  Future <void>call(CreatePostParams params) async {
    return await postRepository.createPost(params.post);
  }
}

class CreatePostParams extends Params {
  final Post post;

  CreatePostParams({required this.post});

  @override
  List<Object?> get props => [post];
}
