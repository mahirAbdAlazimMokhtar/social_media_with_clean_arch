import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insta/src/shared/domain/entities/post.dart';
import 'package:insta/src/shared/presentation/widgets/custom_video_player.dart';

import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widgets/custom_user_info.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user = const User(
        id: '_',
        username: Username.dirty(
          'Mahir',
        ),
        imagePath: 'assets/images/image_3.jpg');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'user.username.value',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          CustomUserInformation(user: user),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffff006e),
                                      fixedSize: const Size(150, 50),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero)),
                                  onPressed: () {
                                    context.goNamed('add_content');
                                  },
                                  child: Text(
                                    'Add Video',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffff006e),
                                      fixedSize: const Size(150, 50),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero)),
                                  onPressed: () {},
                                  child: Text(
                                    'Update Picture',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TabBar(indicatorColor: Colors.white, tabs: [
                            Tab(
                              icon: Icon(Icons.grid_view_outlined),
                            ),
                            Tab(
                              icon: Icon(Icons.favorite),
                            )
                          ])
                        ],
                      ),
                    )
                  ],
              body: TabBarView(
                children: [
                  GridView.builder(
                      itemCount: 9,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 9 / 16,
                      ),
                      itemBuilder: (context, index) {
                        Post post = Post(
                            id: 'id',
                            user: user,
                            caption: 'Test',
                            assetPath: 'assets/videos/video_1.mp4');
                        return CustomVideoPlayer(assetPath: post.assetPath);
                      }),
                  Text('first tab'),
                  Text('Second tab'),
                ],
              )),
        ));
  }
}
