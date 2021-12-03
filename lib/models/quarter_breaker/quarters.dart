import 'package:json_annotation/json_annotation.dart';
import "quarters0.dart";
part 'quarters.g.dart';

@JsonSerializable()
class Quarters {
    Quarters();

    late  Quarters0 api;
    
    factory Quarters.fromJson(Map<String,dynamic> json) => _$QuartersFromJson(json);
    Map<String, dynamic> toJson() => _$QuartersToJson(this);
}
