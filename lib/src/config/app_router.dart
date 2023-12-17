// # Go Router class

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insta/src/features/auth/presentation/views/login_screen.dart';
import 'package:insta/src/features/feed/presentation/view/discover_screen.dart';
import 'package:insta/src/features/feed/presentation/view/feed_screen.dart';

import '../features/auth/presentation/views/singup_screen.dart';



class AppRouter {
  //TODO : add auth bloc as input
  AppRouter();
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: 'feed',
        path: '/feed',
        builder: (context, state) => const FeedScreen(),
      ),
      GoRoute(
          name: 'discover',
          path: '/discover',
          builder: (context, state) => const DiscoverScreen(),
          routes: [
            GoRoute(
              name: 'user',
              path: ':userId',
              builder: (context, state) => const SingupScreen(),
            ),
          ]),
      GoRoute(
        name: 'login',
        path: '/',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            name: 'singup',
            path: 'singup',
            builder: (context, state) => const SingupScreen(),
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
