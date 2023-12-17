import '../../../../shared/domain/usecase/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class SingUpUserUseCase implements UseCase<void, SingUpUserParams> {
  final AuthRepository authRepository;

  SingUpUserUseCase({required this.authRepository});
  @override
  Future<void> call(SingUpUserParams params) {
    return authRepository.singup(
      //TODO: Add another repo to save the user into a database when he/she register 
      loggedInUser: params.user,
    );
  }
}

class SingUpUserParams extends Params {
  final LoggedInUser user;

  SingUpUserParams({required this.user});
  @override
  List<Object?> get props => [
        user,
      ];
}
