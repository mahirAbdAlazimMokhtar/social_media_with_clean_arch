import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/src/features/feed/presentation/controller/bloc/discover_bloc.dart';

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
      body: BlocBuilder<DiscoverBloc,DiscoverState>(builder: (context,state){
        if(state is DiscoverLoading){
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if(state is DiscoverLoaded){
          print(state.users);
          return Container();
        }else{
          return const Text('Something wont wrong');
        }
      }),
    );
  }
}
