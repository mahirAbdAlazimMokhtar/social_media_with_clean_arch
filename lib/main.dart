import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/src/features/auth/domain/usecases/singup_user_usecase.dart';
import 'package:insta/src/features/auth/presentation/controller/cubits/singup/singup_cubit.dart';
import 'package:insta/src/features/feed/data/datasource/mock_feed_datasource.dart';
import 'package:insta/src/features/feed/data/repository/post_repository_impl.dart';



import 'src/config/app_router.dart';
import 'src/config/app_theme.dart';
import 'src/features/auth/data/datasource/mock_auth_datasource.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/usecases/get_auth_status_user_usecase.dart';
import 'src/features/auth/domain/usecases/get_logged_in_user_usecase.dart';
import 'src/features/auth/domain/usecases/login_user_usecase.dart';
import 'src/features/auth/domain/usecases/logout_user_usecase.dart';
import 'src/features/auth/presentation/controller/blocs/auth/auth_bloc.dart';
import 'src/features/auth/presentation/controller/cubits/login/login_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            authDatasource: MockAuthDatasourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PostRepositoryImpl(
            mockFeedDatasource: MocKFeedDatasourceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              logoutUserUseCase: LogoutUserUseCase(
                authRepository: context.read<AuthRepositoryImpl>(),
              ),
              getAuthStatusUseCase: GetAuthStatusUseCase(
                  authRepository: context.read<AuthRepositoryImpl>()),
              getLoggedInUserUseCase: GetLoggedInUserUseCase(
                  authRepository: context.read<AuthRepositoryImpl>()),
            ),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              loginUserUseCase: LoginUserUseCase(
                authRepository: context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          // BlocProvider(
            // create: (context) => FeedBloc(
              // getPostsUsecase: GetPostsUsecase(
                // postRepository: context.read<PostRepositoryImpl>(),
              // ),
            // ),
          // ),
          BlocProvider(
            create: (context) => SingupCubit(
              singUpUserUseCase: SingUpUserUseCase(
                authRepository: context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: CustomTheme().themeData(),
            routerConfig: AppRouter(context.read<AuthBloc>()).router,
          );
        }),
      ),
    );
  }
}
