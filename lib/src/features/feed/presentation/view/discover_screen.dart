import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/src/features/feed/presentation/controller/bloc/discover_bloc.dart';
import 'package:insta/src/shared/domain/entities/user.dart';
import 'package:insta/src/shared/presentation/widgets/custom_gradient_overlay.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Screen'),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<DiscoverBloc, DiscoverState>(builder: (context, state) {
        if (state is DiscoverLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if (state is DiscoverLoaded) {
          if (kDebugMode) {
            print(state.users);
          }
          return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                User user = state.users[index];
                return _DiscoverUserCard(
                  user: user,
                  index: index,
                );
              });
        } else {
          return const Text('Something wont wrong');
        }
      }),
    );
  }
}

class _DiscoverUserCard extends StatelessWidget {
  const _DiscoverUserCard({
    required this.user,
    required this.index,
  });

  final User user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: (index == 0) ? 250 : 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: (user.imagePath == null)
                  ? const AssetImage('assets/images/images_1.jpg')
                  : AssetImage(user.imagePath!),
            ),
          ),
        ),
        const CustomGradientOverlay(
          stops: [0.4, 1.0],
          colors: [Colors.transparent, Colors.black],
        ),
        Positioned(
            left: 10,
            bottom: 10,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: (user.imagePath == null) ? null : AssetImage(user.imagePath!),
                ),
                const SizedBox(width: 10,),
                Text(
                  user.username.value,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ))
      ],
    );
  }
}
