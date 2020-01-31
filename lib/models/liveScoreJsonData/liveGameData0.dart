import 'package:json_annotation/json_annotation.dart';
import "liveGameData01.dart";
part 'liveGameData0.g.dart';

@JsonSerializable()
class LiveGameData0 {
    LiveGameData0();

    LiveGameData01 api;
    
    factory LiveGameData0.fromJson(Map<String,dynamic> json) => _$LiveGameData0FromJson(json);
    Map<String, dynamic> toJson() => _$LiveGameData0ToJson(this);
}
