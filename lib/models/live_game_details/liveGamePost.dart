import 'package:json_annotation/json_annotation.dart';
import "liveGame1.dart";
part 'liveGamePost.g.dart';

@JsonSerializable()
class LiveGamePost {
    LiveGamePost();

    late LiveGame1 api;
    
    factory LiveGamePost.fromJson(Map<String,dynamic> json) => _$LiveGamePostFromJson(json);
    Map<String, dynamic> toJson() => _$LiveGamePostToJson(this);
}
