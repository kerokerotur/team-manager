import 'package:flutter/material.dart';
import 'package:flutter_template/src/data/event.dart';
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
        padding: const EdgeInsets.all(16),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            // TODO: イベント詳細画面への遷移
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // カテゴリアイコン
                CategoryIcon(category: event.category),
                const SizedBox(width: 16),
                // イベント情報
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // タイトル
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 日時
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDateTime(event.dateTime),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // 場所
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            event.location,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // 参加者数
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${event.participantCount}人',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 矢印アイコン
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
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
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _getCategoryColor(category.type),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Icon(
        _getCategoryIcon(category.type),
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Color _getCategoryColor(EventCategoryType type) {
    switch (type) {
      case EventCategoryType.practice:
        return Colors.blue;
      case EventCategoryType.meeting:
        return Colors.purple;
      case EventCategoryType.scrum:
        return Colors.green;
      case EventCategoryType.social:
        return Colors.orange;
      case EventCategoryType.other:
        return Colors.grey;
    }
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