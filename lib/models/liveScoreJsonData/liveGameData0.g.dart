// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveGameData0.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveGameData0 _$LiveGameData0FromJson(Map<String, dynamic> json) {
  return LiveGameData0()
    ..api = (json['api'] == null
        ? null
        : LiveGameData01.fromJson(json['api'] as Map<String, dynamic>))!;
}

Map<String, dynamic> _$LiveGameData0ToJson(LiveGameData0 instance) =>
    <String, dynamic>{'api': instance.api};
