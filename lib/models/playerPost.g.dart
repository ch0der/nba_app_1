// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerPost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerPost _$PlayerPostFromJson(Map<String, dynamic> json) {
  return PlayerPost()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..teamId = json['teamId'] as String
    ..yearsPro = json['yearsPro'] as String
    ..collegeName = json['collegeName'] as String
    ..country = json['country'] as String
    ..playerId = json['playerId'] as String
    ..dateOfBirth = json['dateOfBirth'] as String
    ..affiliation = json['affiliation'] as String
    ..startNba = json['startNba'] as String
    ..heightInMeters = json['heightInMeters'] as String
    ..weightInKilograms = json['weightInKilograms'] as String;
}

Map<String, dynamic> _$PlayerPostToJson(PlayerPost instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'teamId': instance.teamId,
      'yearsPro': instance.yearsPro,
      'collegeName': instance.collegeName,
      'country': instance.country,
      'playerId': instance.playerId,
      'dateOfBirth': instance.dateOfBirth,
      'affiliation': instance.affiliation,
      'startNba': instance.startNba,
      'heightInMeters': instance.heightInMeters,
      'weightInKilograms': instance.weightInKilograms
    };
