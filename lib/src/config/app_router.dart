//app Router using go_router
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insta/main.dart';

class AppRouter {
  //TODO: add the auth bloc as an input 
  AppRouter();

  late final GoRouter router = GoRouter(routes: <GoRoute>[
    GoRoute(
      name: 'feed',
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      name: 'discover',
      path: '/discover',
      builder: (BuildContext context, GoRouterState state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      name: 'user',
      path: 'userId',
      builder: (BuildContext context, GoRouterState state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) => const MyHomePage(
        title: '',
      ),
    ),
  ],
  //redirect: 
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }
  late final StreamSubscription<dynamic> _subscription ;

  @override
  void dispose() {
  _subscription.cancel();
    super.dispose();
  }
}
