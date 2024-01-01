import 'package:insta/src/features/feed/data/datasource/mock_feed_datasource.dart';
import 'package:insta/src/features/feed/domain/repository/post_repository.dart';
import 'package:insta/src/shared/domain/entities/post.dart';

class PostRepositoryImpl implements PostRepository {
  final MockFeedDatasource mockFeedDatasource;
  PostRepositoryImpl({required this.mockFeedDatasource});
  @override
  Future<List<Post>> getPostByUser(String userId) async {
    return mockFeedDatasource.getPostsByUser(userId);
  }

  @override
  Future<List<Post>> getPosts() async {
    return mockFeedDatasource.getPosts();
  }
}
