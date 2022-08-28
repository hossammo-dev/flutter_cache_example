import 'package:hive/hive.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 0, adapterName: 'comment') //adapter for class
class Comment {
  @HiveField(0) //id for each attribute
  int? id;
  @HiveField(1)
  int? postId;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? body;

  Comment({this.id, this.postId, this.name, this.email, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        postId: json['postId'],
        name: json['name'],
        email: json['email'],
        body: json['body'],
      );
}
