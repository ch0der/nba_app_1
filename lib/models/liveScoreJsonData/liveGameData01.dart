import 'package:json_annotation/json_annotation.dart';
import "liveScore0.dart";
part 'liveGameData01.g.dart';

@JsonSerializable()
class LiveGameData01 {
    LiveGameData01();

    num status;
    String message;
    num results;
    List filters;
    List games;
    
    factory LiveGameData01.fromJson(Map<String,dynamic> json) => _$LiveGameData01FromJson(json);
    Map<String, dynamic> toJson() => _$LiveGameData01ToJson(this);
}
