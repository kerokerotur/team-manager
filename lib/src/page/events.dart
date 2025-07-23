import 'package:flutter/material.dart';
import 'package:flutter_template/src/data/event.dart';
import 'package:flutter_template/src/design_system/design_system.dart';
import 'package:flutter_template/src/widgets/app_footer.dart';
import 'package:flutter_template/src/widgets/hamburger_menu.dart';
import 'package:intl/intl.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // サンプルデータ
    final events = _getSampleEvents();

    return Scaffold(
      appBar: AppBar(
        title: const Text('イベント'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: イベント作成画面への遷移
            },
          ),
        ],
      ),
      drawer: const HamburgerMenu(),
      body: ListView.builder(
        padding: AppPadding.screen,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return EventCard(event: event);
        },
      ),
      bottomNavigationBar: const AppFooter(),
    );
  }

  List<Event> _getSampleEvents() {
    return [
      Event(
        id: '1',
        title: 'バスケットボールチームの練習',
        dateTime: DateTime(2025, 5, 15, 18, 0),
        location: '体育館A',
        participantCount: 12,
        category: EventCategory(
          id: '1',
          name: '練習',
          type: EventCategoryType.practice,
        ),
      ),
      Event(
        id: '2',
        title: 'チームの定例会議',
        dateTime: DateTime(2025, 5, 20, 19, 30),
        location: '会議室B',
        participantCount: 8,
        category: EventCategory(
          id: '2',
          name: '会議',
          type: EventCategoryType.meeting,
        ),
      ),
      Event(
        id: '3',
        title: 'チームのスクリム',
        dateTime: DateTime(2025, 5, 25, 14, 0),
        location: 'オンライン',
        participantCount: 10,
        category: EventCategory(
          id: '3',
          name: 'スクリム',
          type: EventCategoryType.scrum,
        ),
      ),
      Event(
        id: '4',
        title: 'チームのバーベキュー',
        dateTime: DateTime(2025, 5, 30, 18, 0),
        location: '公園C',
        participantCount: 15,
        category: EventCategory(
          id: '4',
          name: 'ソーシャル',
          type: EventCategoryType.social,
        ),
      ),
    ];
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).extension<AppTextStyles>();

    return Container(
      margin: AppPadding.only(bottom: AppSpacing.md),
      child: Card(
        child: InkWell(
          onTap: () {
            // TODO: イベント詳細画面への遷移
          },
          borderRadius: AppRadius.cardRadius,
          child: Padding(
            padding: AppPadding.card,
            child: Row(
              children: [
                // カテゴリアイコン
                CategoryIcon(category: event.category),
                AppGap.horizontalMd,
                // イベント情報
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // タイトル
                      Text(
                        event.title,
                        style:
                            textStyles?.eventTitle ?? AppTypography.eventTitle,
                      ),
                      AppGap.sm,
                      // 日時
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: AppDimensions.iconSm,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          AppGap.horizontalXs,
                          Text(
                            _formatDateTime(event.dateTime),
                            style: textStyles?.eventMetadata ??
                                AppTypography.eventMetadata.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                      AppGap.xs,
                      // 場所
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: AppDimensions.iconSm,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          AppGap.horizontalXs,
                          Text(
                            event.location,
                            style: textStyles?.eventMetadata ??
                                AppTypography.eventMetadata.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                      AppGap.xs,
                      // 参加者数
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: AppDimensions.iconSm,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          AppGap.horizontalXs,
                          Text(
                            '${event.participantCount}人',
                            style: textStyles?.eventMetadata ??
                                AppTypography.eventMetadata.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 矢印アイコン
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.outline,
                  size: AppDimensions.iconMd,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('M月d日 H:mm', 'ja');
    return formatter.format(dateTime);
  }
}

class CategoryIcon extends StatelessWidget {
  final EventCategory category;

  const CategoryIcon({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.eventCategoryIconSize,
      height: AppDimensions.eventCategoryIconSize,
      decoration: BoxDecoration(
        color: _getCategoryColor(category.type, context),
        borderRadius:
            BorderRadius.circular(AppDimensions.eventCategoryIconSize / 2),
      ),
      child: Icon(
        _getCategoryIcon(category.type),
        color: AppColors.white,
        size: AppDimensions.iconMd,
      ),
    );
  }

  Color _getCategoryColor(EventCategoryType type, BuildContext context) {
    return DesignUtils.getCategoryColor(context, type.name);
  }

  IconData _getCategoryIcon(EventCategoryType type) {
    switch (type) {
      case EventCategoryType.practice:
        return Icons.sports_basketball;
      case EventCategoryType.meeting:
        return Icons.meeting_room;
      case EventCategoryType.scrum:
        return Icons.groups;
      case EventCategoryType.social:
        return Icons.restaurant;
      case EventCategoryType.other:
        return Icons.event;
    }
  }
}
