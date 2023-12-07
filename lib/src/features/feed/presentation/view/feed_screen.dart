import 'package:flutter/material.dart';
import 'package:insta/src/shared/presentation/widgets/widgets.dart';


class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Feed Screen'),
      ) ,
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}