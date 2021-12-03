import 'package:json_annotation/json_annotation.dart';

part 'quarters0.g.dart';

@JsonSerializable()
class Quarters0 {
    Quarters0();

    late num status;
    late String message;
    late num results;
    late List filters;
    late List game;
    
    factory Quarters0.fromJson(Map<String,dynamic> json) => _$Quarters0FromJson(json);
    Map<String, dynamic> toJson() => _$Quarters0ToJson(this);
}
