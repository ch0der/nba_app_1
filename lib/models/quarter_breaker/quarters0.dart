import 'package:json_annotation/json_annotation.dart';

part 'quarters0.g.dart';

@JsonSerializable()
class Quarters0 {
    Quarters0();

    num status;
    String message;
    num results;
    List filters;
    List game;
    
    factory Quarters0.fromJson(Map<String,dynamic> json) => _$Quarters0FromJson(json);
    Map<String, dynamic> toJson() => _$Quarters0ToJson(this);
}
