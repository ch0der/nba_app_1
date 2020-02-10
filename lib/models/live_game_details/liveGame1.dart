import 'package:json_annotation/json_annotation.dart';

part 'liveGame1.g.dart';

@JsonSerializable()
class LiveGame1 {
    LiveGame1();

    num status;
    String message;
    num results;
    List filters;
    List statistics;
    
    factory LiveGame1.fromJson(Map<String,dynamic> json) => _$LiveGame1FromJson(json);
    Map<String, dynamic> toJson() => _$LiveGame1ToJson(this);
}
