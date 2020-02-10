// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveGame1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveGame1 _$LiveGame1FromJson(Map<String, dynamic> json) {
  return LiveGame1()
    ..status = json['status'] as num
    ..message = json['message'] as String
    ..results = json['results'] as num
    ..filters = json['filters'] as List
    ..statistics = json['statistics'] as List;
}

Map<String, dynamic> _$LiveGame1ToJson(LiveGame1 instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'results': instance.results,
      'filters': instance.filters,
      'statistics': instance.statistics
    };
