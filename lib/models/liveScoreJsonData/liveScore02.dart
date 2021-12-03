import 'package:json_annotation/json_annotation.dart';

part 'liveScore02.g.dart';

@JsonSerializable()
class LiveScore02 {
    LiveScore02();

    late String points;
    
    factory LiveScore02.fromJson(Map<String,dynamic> json) => _$LiveScore02FromJson(json);
    Map<String, dynamic> toJson() => _$LiveScore02ToJson(this);
}
