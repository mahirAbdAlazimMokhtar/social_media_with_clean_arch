import '../../../../shared/domain/entities/post.dart';

abstract class PostRepository{
  Future<List<Post>> getPosts();
  Future<List<Post>>getPostByUser(String userId);
  Future<void> createPost(Post post);
  //Future<void> deleteAllPosts();
}