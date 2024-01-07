import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/src/features/feed/presentation/controller/feed_bloc/feed_bloc.dart';
import 'package:insta/src/shared/domain/entities/post.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Feed '),
        ),
        bottomNavigationBar: const CustomNavBar(),
        body: BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state is FeedLoaded) {
            Post post = state.posts[0];
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                CustomVideoPlayer(
                  assetPath: post.assetPath,
                  caption: post.caption,
                  username: post.user.username.value,
                ),
              ],
            );
          } else {
            return const Text('Something went wrong!');
          }
        }));
  }
}

class CustomVideoPlayer extends StatefulWidget {
  final String assetPath;
  final String? caption;
  final String? username;

  const CustomVideoPlayer(
      {super.key, required this.assetPath, this.caption, this.username});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController controller;
  @override
  void initState() {
    controller = VideoPlayerController.asset(widget.assetPath);
    controller.initialize().then((_) => setState(() {}));
    controller.setLooping(true);
    controller.play();
    // method play => start video and if the video in at the ending this method will starting video from the start
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox();
    } else {
      return AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
