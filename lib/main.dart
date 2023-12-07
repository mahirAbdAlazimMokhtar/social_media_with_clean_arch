


import 'package:flutter/material.dart';

import 'package:insta/src/config/app_router.dart';
import 'package:insta/src/config/app_theme.dart';




void main(){
  runApp(
    const MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: CustomTheme().themeData(),
      routerConfig: AppRouter().router,
    );
  }
}












