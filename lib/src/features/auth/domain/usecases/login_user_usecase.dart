import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/domain/usecase/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class LoginUserUseCase implements UseCase<void, LoginUserParams> {
  final AuthRepository authRepository;

  LoginUserUseCase({required this.authRepository});
  @override
  Future<void> call(LoginUserParams loginUserParams) {
    return authRepository.login(
      username: loginUserParams.username,
      password: loginUserParams.password,
    );
  }
}

class LoginUserParams extends Params {
  final Username username;
  final Password password;

  LoginUserParams({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}
