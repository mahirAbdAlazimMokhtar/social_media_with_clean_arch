import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../controller/feed_bloc/feed_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state is FeedLoaded) {
            return SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: state.posts
                    .map(
                      (post) => CustomVideoPlayer(
                        assetPath: post.assetPath,
                        username: post.user.username.value,
                        caption: post.caption,
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return const Text('Something went wrong!');
          }
        },
      ),
    );
  }
}
