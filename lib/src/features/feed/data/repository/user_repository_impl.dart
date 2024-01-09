import '../datasource/mock_feed_datasource.dart';
import '../../domain/repository/user_repository.dart';
import '../../../../shared/domain/entities/user.dart';

class UserRepositoryImpl implements UserRepository {
  final MockFeedDatasource mocKFeedDatasource;

  UserRepositoryImpl({required this.mocKFeedDatasource});
  @override
  Future<User> getUser(String userId) async {
    return mocKFeedDatasource.getUser(userId);
  }

  @override
  Future<List<User>> getUsers() async {
    return mocKFeedDatasource.getUsers();
  }
}
