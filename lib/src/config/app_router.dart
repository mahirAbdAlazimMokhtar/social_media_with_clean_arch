import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insta/src/features/feed/data/repository/user_repository_impl.dart';
import 'package:insta/src/features/feed/domain/usecase/get_users_usecase.dart';
import 'package:insta/src/features/feed/presentation/controller/bloc/discover_bloc.dart';

import '../features/auth/presentation/controller/blocs/auth/auth_bloc.dart';

import '../features/auth/presentation/views/login_screen.dart';
import '../features/feed/data/repository/post_repository_impl.dart';
import '../features/feed/domain/usecase/get_posts_usecase.dart';
import '../features/feed/presentation/controller/feed_bloc/feed_bloc.dart';
import '../features/feed/presentation/view/discover_screen.dart';
import '../features/feed/presentation/view/feed_screen.dart';

import '../features/auth/presentation/views/singup_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(this.authBloc);
  late final GoRouter router = GoRouter(routes: [
    GoRoute(
      name: 'feed',
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => FeedBloc(
          getPostsUsecase: GetPostsUsecase(
            postRepository: context.read<PostRepositoryImpl>(),
          ),
        )..add(FeedGetPosts()),
        child: const FeedScreen(),
      ),
    ),
    GoRoute(
        name: 'discover',
        path: '/discover',
        builder: (context, state) => BlocProvider(
              create: (context) => DiscoverBloc(
                getUsersUsecase: GetUsersUsecase(
                  userRepository: context.read<UserRepositoryImpl>(),
                ),
              )..add(DiscoverGetUsers()),
              child: const DiscoverScreen(),
            ),
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
    )
  ]);
  // redirect: (BuildContext context, GoRouterState state) {
  // final loginLocation = state.namedLocation('login');
  // final singupLocation = state.namedLocation('singup');
  // final bool isLoggedIn =
  // authBloc.state.status == AuthStatus.authenticated;
  // final isLoggingIn = state.matchedLocation == loginLocation;
  // final isSigningUp = state.matchedLocation == singupLocation;

  // If user is logged in and trying to access login or sign up page -> navigate to feed
  // if (!isLoggedIn && !isLoggingIn && !isSigningUp) {
  // return '/login';
  // }
  // if (isLoggingIn && isLoggedIn) {
  // return '/';
  // }
  // if (isSigningUp && isLoggedIn) {
  // return '/';
  // }
  // return null;
  // },
  // refreshListenable: GoRouterRefreshStream(authBloc.stream));
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
