import 'package:json_annotation/json_annotation.dart';

part 'posts.g.dart';

@JsonSerializable()
class Posts {
    Posts();

    late num status;
    late String message;
    late num results;
    late List filters;
    late List players;
    
    factory Posts.fromJson(Map<String,dynamic> json) => _$PostsFromJson(json);
    Map<String, dynamic> toJson() => _$PostsToJson(this);
}
