// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quarters0.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quarters0 _$Quarters0FromJson(Map<String, dynamic> json) {
  return Quarters0()
    ..status = json['status'] as num
    ..message = json['message'] as String
    ..results = json['results'] as num
    ..filters = json['filters'] as List
    ..game = json['game'] as List;
}

Map<String, dynamic> _$Quarters0ToJson(Quarters0 instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'results': instance.results,
      'filters': instance.filters,
      'game': instance.game
    };
