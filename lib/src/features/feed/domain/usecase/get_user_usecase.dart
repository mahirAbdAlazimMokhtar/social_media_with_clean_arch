import '../repository/user_repository.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/domain/usecase/usecases.dart';

class GetUserUsecase implements UseCase<User, GetUserParams> {
  final UserRepository userRepository;

  GetUserUsecase({required this.userRepository});
  @override
  Future<User> call(GetUserParams params) async {
    return userRepository.getUser(params.userId);
  }
}

class GetUserParams extends Params {
  final String userId;

  GetUserParams({required this.userId});
  @override
  List<Object?> get props => [userId];
}
