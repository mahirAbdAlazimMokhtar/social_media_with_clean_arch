

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecase/get_posts_usecase.dart';
import '../../../../../shared/domain/entities/post.dart';
import '../../../../../shared/domain/usecase/usecases.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPostsUsecase _getPostsUsecase;
  FeedBloc({
    required GetPostsUsecase getPostsUsecase,
  })  : _getPostsUsecase = getPostsUsecase,
        super(FeedLoading()) {
    on<FeedGetPosts>(_onFeedGetPosts);
  }

  void _onFeedGetPosts(FeedGetPosts event, Emitter<FeedState> emit)async {
    debugPrint('Start getting posts with : _onFeedGetPosts');
    List<Post> posts = await _getPostsUsecase(NoParams());
    debugPrint('End getting posts with : _onFeedGetPosts');
    emit(FeedLoaded(posts: posts));
  }
}
