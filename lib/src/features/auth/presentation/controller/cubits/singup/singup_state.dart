part of 'singup_cubit.dart';

class SingupState extends Equatable {
  final Username username;
  final Password password;
  final FormzStatus status;
  final String? errorText;
  final Email email;
  const SingupState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorText,
    this.email = const Email.pure(),
  });

  factory SingupState.initial() {
    return const SingupState(
        username: Username.pure(),
        password: Password.pure(),
        status: FormzStatus.pure,
        errorText: null);
  }

  SingupState copyWith({
    Username? username,
    Password? password,
    FormzStatus? status,
    String? errorText,
    Email? email,
  }) {
    return SingupState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [username, password ,status ,errorText ,email];
}
