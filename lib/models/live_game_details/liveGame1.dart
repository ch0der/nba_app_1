import 'package:json_annotation/json_annotation.dart';

part 'liveGame1.g.dart';

@JsonSerializable()
class LiveGame1 {
    LiveGame1();

    late num status;
    late String message;
    late num results;
    late List filters;
    late List statistics;
    
    factory LiveGame1.fromJson(Map<String,dynamic> json) => _$LiveGame1FromJson(json);
    Map<String, dynamic> toJson() => _$LiveGame1ToJson(this);
}
