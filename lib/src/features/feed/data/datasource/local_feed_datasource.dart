import 'package:hive_flutter/hive_flutter.dart';
import 'package:insta/src/shared/data/models/post_model.dart';
import 'package:insta/src/shared/domain/entities/post.dart';

abstract class LocalFeedDatasource {
  Future<List<Post>> getPosts();
  Future<void> addPost(Post post);
  Future<void> deleteAllPosts();
}

class LocalFeedDataSourceImpl implements LocalFeedDatasource {
  String boxName = 'posts';
  Type boxType = PostModel;
  @override
  Future<void> addPost(Post post) async {
    Box box = await _openBox();
    await box.put(post.id, PostModel.fromEntity(post));
  }

  @override
  Future<void> deleteAllPosts() async {
    Box box = await _openBox();
    await box.clear();
  }

  @override
  Future<List<Post>> getPosts() async {
    Box<PostModel> box = await _openBox() as Box<PostModel>;
    return box.values.toList().map((post) => post.toEntity()).toList();
  }

//! Helper Method
  Future<Box> _openBox() async {
    return Hive.openBox<PostModel>(boxName);
  }
}
