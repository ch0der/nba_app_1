// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveGameDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveGameDetails _$LiveGameDetailsFromJson(Map<String, dynamic> json) {
  return LiveGameDetails()
    ..gameId = json['gameId'] as String
    ..teamId = json['teamId'] as String
    ..points = json['points'] as String
    ..pos = json['pos'] as String
    ..min = json['min'] as String
    ..fgm = json['fgm'] as String
    ..fga = json['fga'] as String
    ..fgp = json['fgp'] as String
    ..ftm = json['ftm'] as String
    ..fta = json['fta'] as String
    ..ftp = json['ftp'] as String
    ..tpm = json['tpm'] as String
    ..tpa = json['tpa'] as String
    ..tpp = json['tpp'] as String
    ..offReb = json['offReb'] as String
    ..defReb = json['defReb'] as String
    ..totReb = json['totReb'] as String
    ..assists = json['assists'] as String
    ..pFouls = json['pFouls'] as String
    ..steals = json['steals'] as String
    ..turnovers = json['turnovers'] as String
    ..blocks = json['blocks'] as String
    ..plusMinus = json['plusMinus'] as String
    ..playerId = json['playerId'] as String;
}

Map<String, dynamic> _$LiveGameDetailsToJson(LiveGameDetails instance) =>
    <String, dynamic>{
      'gameId': instance.gameId,
      'teamId': instance.teamId,
      'points': instance.points,
      'pos': instance.pos,
      'min': instance.min,
      'fgm': instance.fgm,
      'fga': instance.fga,
      'fgp': instance.fgp,
      'ftm': instance.ftm,
      'fta': instance.fta,
      'ftp': instance.ftp,
      'tpm': instance.tpm,
      'tpa': instance.tpa,
      'tpp': instance.tpp,
      'offReb': instance.offReb,
      'defReb': instance.defReb,
      'totReb': instance.totReb,
      'assists': instance.assists,
      'pFouls': instance.pFouls,
      'steals': instance.steals,
      'turnovers': instance.turnovers,
      'blocks': instance.blocks,
      'plusMinus': instance.plusMinus,
      'playerId': instance.playerId
    };
