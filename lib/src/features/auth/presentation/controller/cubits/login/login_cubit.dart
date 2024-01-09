import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../data/datasource/mock_auth_datasource.dart';
import '../../../../domain/entities/logged_in_user.dart';
import '../../../../domain/usecases/login_user_usecase.dart';

import '../../../../../../shared/domain/entities/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase _loginUserUseCase;
  LoginCubit({required LoginUserUseCase loginUserUseCase})
      : _loginUserUseCase = loginUserUseCase,
        super(LoginState.initial());
  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            username,
            state.password,
          ],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    print(password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [
            password,
            state.username,
          ],
        ),
      ),
    );
    print(state.status.isInvalid);
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginUserUseCase(
        LoginUserParams(
          username: state.username,
          password: state.password,
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LoginWithUsernameAndPasswordFailure catch (error) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorText: error.message));
    } catch (err) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
