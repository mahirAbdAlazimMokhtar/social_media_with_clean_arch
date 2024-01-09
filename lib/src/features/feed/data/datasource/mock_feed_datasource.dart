import '../../../../shared/data/datasource/post_data.dart';
import '../../../../shared/data/datasource/user_data.dart';
import '../../../../shared/data/models/post_model.dart';
import '../../../../shared/data/models/user_model.dart';
import '../../../../shared/domain/entities/user.dart';

import '../../../../shared/domain/entities/post.dart';

abstract class MockFeedDatasource {
  Future<List<Post>> getPosts();
  Future<List<Post>> getPostsByUser(String userId);
  //! we want to get all users & specific user by id
  //! so we can get user's posts'
  Future<List<User>> getUsers();
  Future<User> getUser(String userId);
}

class MocKFeedDatasourceImpl implements MockFeedDatasource {
  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    return posts.map((post) {
      Map<String, dynamic> user = users.where((user) {
        return user['id'] == post['userId'];
      }).first;
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    return posts.where((post) => post['userId'] == userId).map((post) {
      Map<String, dynamic> user = users.where((user) {
        return user['id'] == post['userId'];
      }).first;
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
  }

  @override
  Future<User> getUser(String userId) async{
    await Future.delayed(const Duration(milliseconds: 200), () {});
    return UserModel.fromJson(users.where((user) => user['id'] == userId).first).toEntity();
  }

  @override
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
    return users.map((user) {
      return UserModel.fromJson(user).toEntity();
    }).toList();
  }
}
