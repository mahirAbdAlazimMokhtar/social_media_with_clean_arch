import 'package:flutter/material.dart';
import 'package:insta/src/shared/presentation/widgets/widgets.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Screen'),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
