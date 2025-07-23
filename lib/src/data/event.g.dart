// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      location: json['location'] as String,
      participantCount: (json['participantCount'] as num).toInt(),
      category:
          EventCategory.fromJson(json['category'] as Map<String, dynamic>),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'dateTime': instance.dateTime.toIso8601String(),
      'location': instance.location,
      'participantCount': instance.participantCount,
      'category': instance.category,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };

_$EventCategoryImpl _$$EventCategoryImplFromJson(Map<String, dynamic> json) =>
    _$EventCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$EventCategoryTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$EventCategoryImplToJson(_$EventCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$EventCategoryTypeEnumMap[instance.type]!,
    };

const _$EventCategoryTypeEnumMap = {
  EventCategoryType.practice: 'practice',
  EventCategoryType.meeting: 'meeting',
  EventCategoryType.scrum: 'scrum',
  EventCategoryType.social: 'social',
  EventCategoryType.other: 'other',
};
