import 'package:flutter/foundation.dart';
import 'package:insta/src/features/feed/data/datasource/local_feed_datasource.dart';

import '../datasource/mock_feed_datasource.dart';
import '../../domain/repository/post_repository.dart';
import '../../../../shared/domain/entities/post.dart';

class PostRepositoryImpl implements PostRepository {
  final MockFeedDatasource mockFeedDatasource;
  final LocalFeedDatasource localFeedDatasource;
  PostRepositoryImpl(
      {required this.mockFeedDatasource, required this.localFeedDatasource});
  @override
  Future<List<Post>> getPostByUser(String userId) async {
    return mockFeedDatasource.getPostsByUser(userId);
  }

  @override
  Future<List<Post>> getPosts() async {
    //Check internet connection . Get from Database
    // if there is a active connection  . Else get from local Hive

    if ((await localFeedDatasource.getPosts()).isEmpty) {
      List<Post> posts = await mockFeedDatasource.getPosts();
      for (final post in posts) {
        localFeedDatasource.addPost(post);
      }
      return posts;
    } else {
      if (kDebugMode) {
        print('Getting the post From Hive');
      }
      return localFeedDatasource.getPosts();
    }
  }
}
