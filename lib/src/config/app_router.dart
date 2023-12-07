// # Go Router class

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insta/main.dart';

class AppRouter {
  //TODO : add auth bloc as input
  AppRouter();
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: 'feed',
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          name: 'discover',
          path: '/discover',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              name: 'user',
              path: ':userId',
              builder: (context, state) => const HomeScreen(),
            ),
          ]),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            name: 'singup',
            path: 'singup',
            builder: (context, state) => const HomeScreen(),
          ),
        ],
        //TODO: Redirect users to the login screen if they're not auth . else go to the feed screen 
       // redirect: 
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((event) {
      notifyListeners();
    });
  }
  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
