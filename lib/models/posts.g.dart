// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) {
  return Posts()
    ..status = json['status'] as num
    ..message = json['message'] as String
    ..results = json['results'] as num
    ..filters = json['filters'] as List
    ..players = json['players'] as List;
}

Map<String, dynamic> _$PostsToJson(Posts instance) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'results': instance.results,
  'filters': instance.filters,
  'players': instance.players
};