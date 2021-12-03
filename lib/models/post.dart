import 'package:json_annotation/json_annotation.dart';
import "posts.dart";
part 'post.g.dart';

@JsonSerializable()
class Post {
    Post();

    late Posts api;
    
    factory Post.fromJson(Map<String,dynamic> json) => _$PostFromJson(json);
    Map<String, dynamic> toJson() => _$PostToJson(this);
}
