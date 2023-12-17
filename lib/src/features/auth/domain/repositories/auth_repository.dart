//thats is interface abstract class for auth rep
import '../../../../shared/domain/entities/user.dart';
import '../../data/datasource/mock_auth_datasource.dart';
import '../entities/logged_in_user.dart';








abstract class AuthRepository {
  Stream<AuthStatus> get status;
  //check the user logged in or not
  Future<LoggedInUser> get loggedInUser;
  //check the user singup or not
  Future<void> singup({required LoggedInUser loggedInUser});
  //check the user login or not
  Future<void> login({required Username username, required Password password});
  //user logout
  Future<void> logout();
}
