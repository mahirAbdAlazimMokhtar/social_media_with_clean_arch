import 'package:insta/src/features/feed/domain/repository/user_repository.dart';
import 'package:insta/src/shared/domain/entities/user.dart';
import 'package:insta/src/shared/domain/usecase/usecases.dart';

class GetUsersUsecase implements UseCase<List<User>, NoParams> {
  final UserRepository userRepository;

  GetUsersUsecase({required this.userRepository});
  @override
  Future<List<User>> call(NoParams params) async {
    return userRepository.getUsers();
  }
}
