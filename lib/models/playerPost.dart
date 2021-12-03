import 'package:json_annotation/json_annotation.dart';

part 'playerPost.g.dart';

@JsonSerializable()
class PlayerPost {
    PlayerPost();

    late String firstName;
    late String lastName;
    late String teamId;
    late String yearsPro;
    late String collegeName;
    late String country;
    late String playerId;
    late String dateOfBirth;
    late String affiliation;
    late String startNba;
    late String heightInMeters;
    late String weightInKilograms;
    
    factory PlayerPost.fromJson(Map<String,dynamic> json) => _$PlayerPostFromJson(json);
    Map<String, dynamic> toJson() => _$PlayerPostToJson(this);
}
