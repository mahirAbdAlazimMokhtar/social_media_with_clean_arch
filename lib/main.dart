


import 'package:flutter/material.dart';
import 'package:insta/src/config/app_theme.dart';
import 'package:insta/src/shared/presentation/widgets/widgets.dart';


void main(){
  runApp(
    const MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme().themeData(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Flutter app with clean arch'),
      ) ,
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}