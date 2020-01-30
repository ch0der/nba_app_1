// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post()
    ..api = json['api'] == null
        ? null
        : Posts.fromJson(json['api'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PostToJson(Post instance) =>
    <String, dynamic>{'api': instance.api};
