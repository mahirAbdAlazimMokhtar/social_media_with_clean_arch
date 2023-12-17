import 'package:insta/src/shared/domain/usecase/usecases.dart';

import '../repositories/auth_repository.dart';

class LoggedInUserUseCase implements UseCase<void , NoParams> {
  final AuthRepository authRepository;

  LoggedInUserUseCase({required this.authRepository});
  @override
  Future<void> call(NoParams noParams){
    return authRepository.loggedInUser;
  }
}