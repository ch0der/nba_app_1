import 'package:json_annotation/json_annotation.dart';
import "playerPost.dart";
part 'posts.g.dart';

@JsonSerializable()
class Posts {
    Posts();

    num status;
    String message;
    num results;
    List filters;
    List<PlayerPost> players;
    
    factory Posts.fromJson(Map<String,dynamic> json) => _$PostsFromJson(json);
    Map<String, dynamic> toJson() => _$PostsToJson(this);
}
