import '../../../../shared/domain/usecase/usecases.dart';

import '../repositories/auth_repository.dart';

class LogoutUserUseCase implements UseCase<void , NoParams> {
  final AuthRepository authRepository;

  LogoutUserUseCase({required this.authRepository});
  @override
  Future<void> call(NoParams noParams){
    return authRepository.logout();
  }
}