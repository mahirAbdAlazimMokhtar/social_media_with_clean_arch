import 'dart:io';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'custom_gradient_overlay.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String assetPath;
  final String? caption;
  final String? username;

  const CustomVideoPlayer({
    super.key,
    required this.assetPath,
    this.caption,
    this.username,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  @override
void initState() {
  if (widget.assetPath.startsWith('assets')) {
     print('Initializing VideoPlayerController from asset: ${widget.assetPath}');
    _controller = VideoPlayerController.asset(widget.assetPath);
  } else {
    _controller = VideoPlayerController.file(File(widget.assetPath));
  }

  _controller.initialize().then((_) {
     print('VideoController initialized successfully.');
    setState(() {});
  }).catchError((error) {
    print("Error initializing video controller: $error");
  });

  _controller.setLooping(true);
  _controller.play();

  super.initState();
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(children: [
            VideoPlayer(_controller),
            const CustomGradientOverlay(),
            (widget.caption == null || widget.username == null)
                ? const SizedBox()
                : _VideoCaption(
                    username: widget.username!,
                    caption: widget.caption!,
                  ),
          ]),
        ),
      );
    }
  }
}

class _VideoCaption extends StatelessWidget {
  const _VideoCaption({
    Key? key,
    required this.username,
    required this.caption,
  }) : super(key: key);

  final String username;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 125,
        width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              username,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 5),
            Text(
              caption,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
