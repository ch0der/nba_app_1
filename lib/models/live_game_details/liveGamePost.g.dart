// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveGamePost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveGamePost _$LiveGamePostFromJson(Map<String, dynamic> json) {
  return LiveGamePost()
    ..api = json['api'] == null
        ? null
        : LiveGame1.fromJson(json['api'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LiveGamePostToJson(LiveGamePost instance) =>
    <String, dynamic>{'api': instance.api};
