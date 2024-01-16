import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta/src/features/content/domain/usecase/create_post_usecase.dart';
import 'package:insta/src/shared/domain/entities/post.dart';
import 'package:insta/src/shared/domain/entities/user.dart';
import 'package:uuid/uuid.dart';

part 'add_content_state.dart';

class AddContentCubit extends Cubit<AddContentState> {
  AddContentCubit({required CreatePostUsecase createPostUsecase})
      : _createPostUsecase = createPostUsecase,
        super(AddContentState.initial());
  final CreatePostUsecase _createPostUsecase;

  void videoChanged(File file) {
    emit(state.copyWith(
      video: file,
      status: AddContentStatus.loading,
    ));
  }

  void captionChanged(String caption) {
    emit(state.copyWith(caption: caption, status: AddContentStatus.loading));
  }

  void reset() {
    emit(AddContentState.initial());
  }

  void submit(User user) {
    try {
      final post = Post(
          id: const Uuid().v4(),
          user: user,
          caption: state.caption,
          assetPath: state.video!.path);
      _createPostUsecase(CreatePostParams(post: post));
      print('the Post Has been Created');
      emit(state.copyWith(status: AddContentStatus.success));
    } catch (e) {
      print(e);
    }
  }
}
