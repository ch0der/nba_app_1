// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Standings _$StandingsFromJson(Map<String, dynamic> json) {
  return Standings()
    ..league = json['league'] as String
    ..teamId = json['teamId'] as String
    ..win = json['win'] as String
    ..loss = json['loss'] as String
    ..gamesBehind = json['gamesBehind'] as String
    ..lastTenWin = json['lastTenWin'] as String
    ..lastTenLoss = json['lastTenLoss'] as String
    ..streak = json['streak'] as String
    ..seasonYear = json['seasonYear'] as String
    ..conference = json['conference'] as Map<String, dynamic>
    ..division = json['division'] as Map<String, dynamic>
    ..winPercentage = json['winPercentage'] as String
    ..lossPercentage = json['lossPercentage'] as String
    ..home = json['home'] as Map<String, dynamic>
    ..away = json['away'] as Map<String, dynamic>
    ..winStreak = json['winStreak'] as String
    ..tieBreakerPoints = json['tieBreakerPoints'] as String;
}

Map<String, dynamic> _$StandingsToJson(Standings instance) => <String, dynamic>{
      'league': instance.league,
      'teamId': instance.teamId,
      'win': instance.win,
      'loss': instance.loss,
      'gamesBehind': instance.gamesBehind,
      'lastTenWin': instance.lastTenWin,
      'lastTenLoss': instance.lastTenLoss,
      'streak': instance.streak,
      'seasonYear': instance.seasonYear,
      'conference': instance.conference,
      'division': instance.division,
      'winPercentage': instance.winPercentage,
      'lossPercentage': instance.lossPercentage,
      'home': instance.home,
      'away': instance.away,
      'winStreak': instance.winStreak,
      'tieBreakerPoints': instance.tieBreakerPoints
    };
