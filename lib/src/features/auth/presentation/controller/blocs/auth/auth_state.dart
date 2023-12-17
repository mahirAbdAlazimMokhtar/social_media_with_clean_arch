import 'package:equatable/equatable.dart';

import '../../../../data/datasource/mock_auth_datasource.dart';
import '../../../../domain/entities/logged_in_user.dart';

 class AuthState extends Equatable {
  final AuthStatus status;
  final LoggedInUser user;
  const AuthState._(
      {this.status = AuthStatus.unknown, this.user = LoggedInUser.empty});

  const AuthState.unknown() : this._();
  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  const AuthState.authenticated({required LoggedInUser user})
      : this._(status: AuthStatus.authenticated, user: user);



  @override
  List<Object> get props => [status,user];
}
