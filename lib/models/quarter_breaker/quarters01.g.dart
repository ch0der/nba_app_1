// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quarters01.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quarters01 _$Quarters01FromJson(Map<String, dynamic> json) {
  return Quarters01()
    ..seasonYear = json['seasonYear'] as String
    ..league = json['league'] as String
    ..gameId = json['gameId'] as String
    ..startTimeUTC = json['startTimeUTC'] as String
    ..endTimeUTC = json['endTimeUTC'] as String
    ..arena = json['arena'] as String
    ..city = json['city'] as String
    ..country = json['country'] as String
    ..clock = json['clock'] as String
    ..gameDuration = json['gameDuration'] as String
    ..timesTied = json['timesTied'] as String
    ..leadChanges = json['leadChanges'] as String
    ..currentPeriod = json['currentPeriod'] as String
    ..halftime = json['halftime'] as String
    ..endOfPeriod = json['EndOfPeriod'] as String
    ..seasonStage = json['seasonStage'] as String
    ..statusShortGame = json['statusShortGame'] as String
    ..statusGame = json['statusGame'] as String
    ..vTeam = json['vTeam'] as Map<String, dynamic>
    ..hTeam = json['hTeam'] as Map<String, dynamic>
    ..officials = json['officials'] as List;
}

Map<String, dynamic> _$Quarters01ToJson(Quarters01 instance) =>
    <String, dynamic>{
      'seasonYear': instance.seasonYear,
      'league': instance.league,
      'gameId': instance.gameId,
      'startTimeUTC': instance.startTimeUTC,
      'endTimeUTC': instance.endTimeUTC,
      'arena': instance.arena,
      'city': instance.city,
      'country': instance.country,
      'clock': instance.clock,
      'gameDuration': instance.gameDuration,
      'timesTied': instance.timesTied,
      'leadChanges': instance.leadChanges,
      'currentPeriod': instance.currentPeriod,
      'halftime': instance.halftime,
      'EndOfPeriod': instance.endOfPeriod,
      'seasonStage': instance.seasonStage,
      'statusShortGame': instance.statusShortGame,
      'statusGame': instance.statusGame,
      'vTeam': instance.vTeam,
      'hTeam': instance.hTeam,
      'officials': instance.officials
    };
