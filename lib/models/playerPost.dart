import 'package:json_annotation/json_annotation.dart';

part 'playerPost.g.dart';

@JsonSerializable()
class PlayerPost {
    PlayerPost();

    String firstName;
    String lastName;
    String teamId;
    String yearsPro;
    String collegeName;
    String country;
    String playerId;
    String dateOfBirth;
    String affiliation;
    String startNba;
    String heightInMeters;
    String weightInKilograms;
    
    factory PlayerPost.fromJson(Map<String,dynamic> json) => _$PlayerPostFromJson(json);
    Map<String, dynamic> toJson() => _$PlayerPostToJson(this);
}
