import 'package:insta/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:insta/src/shared/domain/usecase/usecases.dart';

import '../repositories/auth_repository.dart';

class GetLoggedInUserUseCase implements UseCase<void , NoParams> {
  final AuthRepository authRepository;

  GetLoggedInUserUseCase({required this.authRepository});
  @override
  Future<LoggedInUser> call(NoParams noParams){
    return authRepository.loggedInUser;
  }
}