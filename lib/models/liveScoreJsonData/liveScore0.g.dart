// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveScore0.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveScore0 _$LiveScore0FromJson(Map<String, dynamic> json) {
  return LiveScore0()
    ..seasonYear = json['seasonYear'] as String
    ..league = json['league'] as String
    ..gameId = json['gameId'] as String
    ..seasonStageId = json['seasonStageId'] as String
    ..statusNum = json['statusNum'] as String
    ..startTimeUTC = json['startTimeUTC'] as String
    ..endTimeUTC = json['endTimeUTC'] as String
    ..arena = json['arena'] as String
    ..city = json['city'] as String
    ..country = json['country'] as String
    ..infos = json['infos'] as String
    ..vTeam = json['vTeam'] == null
        ? null
        : LiveScore01.fromJson(json['vTeam'] as Map<String, dynamic>)
    ..hTeam = json['hTeam'] == null
        ? null
        : LiveScore01.fromJson(json['hTeam'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LiveScore0ToJson(LiveScore0 instance) =>
    <String, dynamic>{
      'seasonYear': instance.seasonYear,
      'league': instance.league,
      'gameId': instance.gameId,
      'seasonStageId': instance.seasonStageId,
      'statusNum': instance.statusNum,
      'startTimeUTC': instance.startTimeUTC,
      'endTimeUTC': instance.endTimeUTC,
      'arena': instance.arena,
      'city': instance.city,
      'country': instance.country,
      'infos': instance.infos,
      'vTeam': instance.vTeam,
      'hTeam': instance.hTeam
    };
