import 'package:equatable/equatable.dart';
import 'package:insta/src/features/auth/data/datasource/mock_auth_datasource.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthGetStatus extends AuthEvent {
  final AuthStatus status;

  const AuthGetStatus({required this.status});
   @override
 List<Object> get props => [status];
}

class AuthLogoutUser extends AuthEvent {}
