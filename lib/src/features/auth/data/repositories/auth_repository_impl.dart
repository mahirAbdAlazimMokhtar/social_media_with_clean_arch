import '../datasource/mock_auth_datasource.dart';
import '../../domain/entities/logged_in_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../shared/domain/entities/user.dart';

class AuthRepositoryImpl extends AuthRepository {
  final MockAuthDatasource authDatasource;
  AuthRepositoryImpl({required this.authDatasource});
  @override
  Future<LoggedInUser> get loggedInUser => authDatasource.loggedInUser;

  @override
  Future<void> login({
    required Username username,
    required Password password,
  }) {
    return authDatasource.login(username: username, password: password);
  }

  @override
  Future<void> logout() {
    return authDatasource.logout();
  }

  @override
  Future<void> singup({required LoggedInUser loggedInUser}) {
   
    return authDatasource.singup(loggedInUser: loggedInUser);   
      }

  @override
 
  Stream<AuthStatus> get status => authDatasource.status;
}
