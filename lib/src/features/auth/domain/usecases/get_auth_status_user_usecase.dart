import '../../data/datasource/mock_auth_datasource.dart';
import '../../../../shared/domain/usecase/usecases.dart';

import '../repositories/auth_repository.dart';

class GetAuthStatusUseCase implements UseCase<void , NoParams> {
  final AuthRepository authRepository;

  GetAuthStatusUseCase({required this.authRepository});
  @override
  Stream<AuthStatus> call(NoParams noParams){
    return authRepository.status;
  }
}