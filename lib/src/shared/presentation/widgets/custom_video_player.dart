import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'custom_gradient_overlay.dart';

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
      return GestureDetector(
        onTap: () {
          setState(() {
            controller.value.isPlaying ? controller.pause() : controller.play();
          });
        },
        child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(controller),
                const CustomGradientOverlay(),
                (widget.caption == null || widget.username == null)
                    ? const SizedBox()
                    : _VideoCaption(widget: widget)
              ],
            )),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _VideoCaption extends StatelessWidget {
  const _VideoCaption({
    super.key,
    required this.widget,
  });

  final CustomVideoPlayer widget;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: 125,
          padding: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.username!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 5,),
              Text(
                widget.caption!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
  }
}
