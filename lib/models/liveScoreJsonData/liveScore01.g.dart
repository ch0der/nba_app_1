// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveScore01.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveScore01 _$LiveScore01FromJson(Map<String, dynamic> json) {
  return LiveScore01()
    ..teamId = json['teamId'] as String
    ..score = (json['score'] == null
        ? null
        : LiveScore02.fromJson(json['score'] as Map<String, dynamic>))!;
}

Map<String, dynamic> _$LiveScore01ToJson(LiveScore01 instance) =>
    <String, dynamic>{'teamId': instance.teamId, 'score': instance.score};
