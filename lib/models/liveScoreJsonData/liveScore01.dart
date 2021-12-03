import 'package:json_annotation/json_annotation.dart';
import "liveScore02.dart";
part 'liveScore01.g.dart';

@JsonSerializable()
class LiveScore01 {
    LiveScore01();

    late String teamId;
    late LiveScore02 score;
    
    factory LiveScore01.fromJson(Map<String,dynamic> json) => _$LiveScore01FromJson(json);
    Map<String, dynamic> toJson() => _$LiveScore01ToJson(this);
}
