import 'package:json_annotation/json_annotation.dart';

part 'liveGameData01.g.dart';

@JsonSerializable()
class LiveGameData01 {
    LiveGameData01();

    late num status;
    late String message;
    late num results;
    late List filters;
    late List games;
    
    factory LiveGameData01.fromJson(Map<String,dynamic> json) => _$LiveGameData01FromJson(json);
    Map<String, dynamic> toJson() => _$LiveGameData01ToJson(this);
}
