import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecase/get_users_usecase.dart';
import '../../../../../shared/domain/entities/user.dart';
import '../../../../../shared/domain/usecase/usecases.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetUsersUsecase _getUsersUsecase;
  DiscoverBloc({required GetUsersUsecase getUsersUsecase})
      : _getUsersUsecase = getUsersUsecase,
        super(DiscoverLoading()) {
    on<DiscoverGetUsers>((_onDiscoverGetUsers));
  }
  void _onDiscoverGetUsers(
    DiscoverGetUsers event,
    Emitter<DiscoverState> emit,
  ) async {
    debugPrint('Start getting users with: _onDiscoverGetUsers');
    List<User> users = await _getUsersUsecase(NoParams());
    emit(DiscoverLoaded(users: users));
  }
}
