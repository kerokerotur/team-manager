import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required DateTime dateTime,
    required String location,
    required int participantCount,
    required EventCategory category,
    String? description,
    String? imageUrl,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
class EventCategory with _$EventCategory {
  const factory EventCategory({
    required String id,
    required String name,
    required EventCategoryType type,
  }) = _EventCategory;

  factory EventCategory.fromJson(Map<String, dynamic> json) => _$EventCategoryFromJson(json);
}

enum EventCategoryType {
  practice,
  meeting,
  scrum,
  social,
  other,
}

extension EventCategoryTypeExtension on EventCategoryType {
  String get displayName {
    switch (this) {
      case EventCategoryType.practice:
        return '練習';
      case EventCategoryType.meeting:
        return '会議';
      case EventCategoryType.scrum:
        return 'スクリム';
      case EventCategoryType.social:
        return 'ソーシャル';
      case EventCategoryType.other:
        return 'その他';
    }
  }

  String get iconName {
    switch (this) {
      case EventCategoryType.practice:
        return 'sports_basketball';
      case EventCategoryType.meeting:
        return 'meeting_room';
      case EventCategoryType.scrum:
        return 'groups';
      case EventCategoryType.social:
        return 'restaurant';
      case EventCategoryType.other:
        return 'event';
    }
  }
}