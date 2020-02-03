// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveGameData01.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveGameData01 _$LiveGameData01FromJson(Map<String, dynamic> json) {
  return LiveGameData01()
    ..status = json['status'] as num
    ..message = json['message'] as String
    ..results = json['results'] as num
    ..filters = json['filters'] as List
    ..games = json['games'] as List;
}

Map<String, dynamic> _$LiveGameData01ToJson(LiveGameData01 instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'results': instance.results,
      'filters': instance.filters,
      'games': instance.games
    };
