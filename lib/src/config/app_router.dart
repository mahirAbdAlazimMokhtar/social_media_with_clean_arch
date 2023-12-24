// # Go Router class

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insta/src/features/auth/data/datasource/mock_auth_datasource.dart';
import 'package:insta/src/features/auth/presentation/controller/blocs/auth/auth_bloc.dart';
import 'package:insta/src/features/auth/presentation/controller/blocs/auth/auth_state.dart';
import 'package:insta/src/features/auth/presentation/views/login_screen.dart';
import 'package:insta/src/features/feed/presentation/view/discover_screen.dart';
import 'package:insta/src/features/feed/presentation/view/feed_screen.dart';

import '../features/auth/presentation/views/singup_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(this.authBloc);
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: 'feed',
        path: '/',
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
        path: '/login',
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
    redirect: (BuildContext context, GoRouterState state) {
      final loginLocation = state.namedLocation('login');
      final singupLocation = state.namedLocation('singup');
      final bool isLoggedIn = authBloc.state.status == AuthStatus.authenticated;
      final isLoggingIn = state.matchedLocation == loginLocation;
      final isSigningUp = state.matchedLocation == singupLocation;

      /// If user is logged in and trying to access login or sign up page -> navigate to feed
      if (!isLoggedIn && !isLoggingIn && !isSigningUp) {
        return '/login';
      }
      if (isLoggingIn && isLoggedIn) {
        return '/';
      }
      if (isSigningUp && isLoggedIn) {
        return '/';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream)
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
