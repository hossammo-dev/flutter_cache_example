import 'package:hive/hive.dart';

import '../models/comment_model.dart';

const String _boxName = "comments_box";

class LocalDataSource {
  static Future<Box> openBox() async {
    final Box _box = await Hive.openBox<Comment>(_boxName);
    return _box;
  }

  //add or create
  static Future<void> addItems(Box box, Comment comment) async =>
      await box.put(comment.id, comment);

  //get or read
  static List<Comment> getComments(Box box) => box.values.toList() as List<Comment>;

  //delete or remove
  Future<void> remove(Box box, String key) async => await box.delete(key);

  //delete all
  Future<void> removeAll(Box box) async => await box.clear();
}
