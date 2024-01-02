import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/src/features/feed/presentation/controller/feed_bloc/feed_bloc.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Feed Screen'),
        ),
        bottomNavigationBar: const CustomNavBar(),
        body: BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state is FeedLoaded) {
            print(state.posts);
            return Container();
          }else {
            return const Text('Something went wrong!');
          }
          
        }));
  }
}
