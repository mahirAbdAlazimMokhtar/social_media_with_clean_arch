import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/domain/usecase/usecases.dart';
import '../../../../data/datasource/mock_auth_datasource.dart';
import '../../../../domain/usecases/get_auth_status_user_usecase.dart';
import '../../../../domain/usecases/get_logged_in_user_usecase.dart';
import '../../../../domain/usecases/logout_user_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUserUseCase _logoutUserUseCase;
  final GetAuthStatusUseCase _getAuthStatusUseCase;
  final GetLoggedInUserUseCase _getLoggedInUserUseCase;

  late StreamSubscription<AuthStatus> _authStreamSubscription;
  AuthBloc(
      {required LogoutUserUseCase logoutUserUseCase,
      required GetAuthStatusUseCase getAuthStatusUseCase,
      required GetLoggedInUserUseCase getLoggedInUserUseCase})
      : _logoutUserUseCase = logoutUserUseCase,
        _getAuthStatusUseCase = getAuthStatusUseCase,
        _getLoggedInUserUseCase = getLoggedInUserUseCase,
        super(const AuthState.unknown()) {
    on<AuthGetStatus>((_onAuthGetStatus));
    on<AuthLogoutUser>((_onAuthLogoutUser));
    _authStreamSubscription =
        _getAuthStatusUseCase(NoParams()).listen((status) {
      add(AuthGetStatus(status: status));
    });
  }

  Future<void> _onAuthGetStatus(
    AuthGetStatus event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('Get AuthGetStatus : ${event.status}');
    switch (event.status) {
      case AuthStatus.unauthenticated:
        emit(const AuthState.unauthenticated());
        break;
      case AuthStatus.authenticated:
        final user = await _getLoggedInUserUseCase(NoParams());
        if (kDebugMode) {
          print(user);
        }
        emit(AuthState.authenticated(user: user));
        break;
      case AuthStatus.unknown:
        emit(const AuthState.unknown());
        break;
    }
  }

  void _onAuthLogoutUser(AuthLogoutUser event, Emitter<AuthState> emit) async {
    debugPrint('Start user Logout With _onAuthLogoutUser');
    await _logoutUserUseCase(NoParams());
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    return super.close();
  }
}
