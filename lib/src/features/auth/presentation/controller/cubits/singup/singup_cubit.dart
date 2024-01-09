import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../../../domain/entities/logged_in_user.dart';
import '../../../../domain/usecases/singup_user_usecase.dart';
import '../../../../../../shared/domain/entities/user.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  final SingUpUserUseCase _singUpUserUseCase;
  SingupCubit({required SingUpUserUseCase singUpUserUseCase})
      : _singUpUserUseCase = singUpUserUseCase,
        super(SingupState.initial());

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            username,
            state.username,
            state.password,
          ],
        ),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [
            email,
            state.password,
            state.username,
          ],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    if (kDebugMode) {
      print(password);
    }
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [
            password,
            state.username,
            state.email,
          ],
        ),
      ),
    );
    if (kDebugMode) {
      print(state.status.isInvalid);
    }
  }

  Future<void> singUpWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _singUpUserUseCase(
        SingUpUserParams(
          user: LoggedInUser(
            id: 'user_0',
            email: state.email,
            username: state.username,
            imagePath: 'assets/images/image_1.jpg',
          ),
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
