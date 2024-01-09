import '../datasource/mock_feed_datasource.dart';
import '../../domain/repository/post_repository.dart';
import '../../../../shared/domain/entities/post.dart';

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
