part of 'singup_cubit.dart';

sealed class SingupState extends Equatable {
  const SingupState();

  @override
  List<Object> get props => [];
}

final class SingupInitial extends SingupState {}
