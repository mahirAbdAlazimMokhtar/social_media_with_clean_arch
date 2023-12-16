//create mock auth datasource
import 'dart:async';

import 'package:insta/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:insta/src/shared/domain/entities/user.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  ;
}

abstract class MockAuthDatasource {
  Stream<AuthStatus> get status;
  //check the user logged in or not
  Future<LoggedInUser> get loggedInUser;
  //check the user singup or not
  Future<void> singup({required LoggedInUser loggedInUser});
  //check the user login or not
  Future<void> login({required Username username, required Password password});
  //user logout
  Future<void> logout();
}

class MockAuthDatasourceImpl extends MockAuthDatasource {
  MockAuthDatasourceImpl({CacheClient? cache})
      : _cache = cache ?? CacheClient();
  final CacheClient _cache;
  static const userCacheKey = '__user_cache_key';

  final _controller = StreamController<AuthStatus>();
  @override
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<LoggedInUser> get loggedInUser {
    return Future.delayed(const Duration(milliseconds: 300), () {
      return _cache.read(key: userCacheKey) ?? LoggedInUser.empty;
    });
  }

  // Mock List Of User for Login
  final List<User> _allUser = <User>[
    const User(
      id: '1',
      username: Username.dirty('Mahir'),
      imagePath: 'assets/images/image_1.jpg',
    ),
    const User(
      id: '2',
      username: Username.dirty('Ali'),
      imagePath: 'assets/images/image_2.jpg',
    ),
    const User(
      id: '3',
      username: Username.dirty('Ahmed'),
      imagePath: 'assets/images/image_3.jpg',
    )
  ];

  @override
  Future<void> singup({required LoggedInUser loggedInUser}) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _allUser.add(loggedInUser);
      _updateLoggedInUser(
        id: loggedInUser.id,
        username: loggedInUser.username,
        email: loggedInUser.email,
      );
      _controller.add(AuthStatus.unauthenticated);
    });
  }

  @override
  Future<void> login({required Username username, required Password password}) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      for (final user in _allUser) {
        if (user.username.value == username.value) {
          _updateLoggedInUser(username: user.username,id: user.id);
          _controller.add(AuthStatus.authenticated);
          return;
        }
      }
    });
  }

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _cache.write(key: userCacheKey, value: LoggedInUser.empty);
      _controller.add(AuthStatus.unauthenticated);
    });
  }

  void _updateLoggedInUser({String? id, Username? username, Email? email}) {
    LoggedInUser loggedInUser =
        _cache.read(key: userCacheKey) ?? LoggedInUser.empty;
    _cache.write(
        key: userCacheKey,
        value: loggedInUser.copyWith(id: id, username: username, email: email));
  }
}

class CacheClient {
  //private constr
  CacheClient() : _cache = <String, Object>{};
  final Map<String, Object> _cache;
  //write
  //store a value in the cache
  /*
  it takes a key of type String 
  and value of a generic type T 
  */
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  //read
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) {
      return value;
    } else {
      return null;
    }
  }
}
