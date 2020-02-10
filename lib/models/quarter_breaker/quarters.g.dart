// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quarters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quarters _$QuartersFromJson(Map<String, dynamic> json) {
  return Quarters()
    ..api = json['api'] == null
        ? null
        : Quarters0.fromJson(json['api'] as Map<String, dynamic>);
}

Map<String, dynamic> _$QuartersToJson(Quarters instance) =>
    <String, dynamic>{'api': instance.api};
