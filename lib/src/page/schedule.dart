import 'package:flutter/material.dart';
import 'package:flutter_template/src/widgets/app_footer.dart';
import 'package:flutter_template/src/widgets/hamburger_menu.dart';
import 'package:flutter_template/src/widgets/event_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // サンプルイベントデータ
  final Map<DateTime, List<Event>> _events = {
    DateTime.utc(2025, 7, 10): [Event('定例ミーティング')],
    DateTime.utc(2025, 7, 15): [Event('プロジェクトA締切'), Event('クライアント訪問')],
    DateTime.utc(2025, 7, 22): [Event('チームランチ')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    // implementation of _getEventsForDay
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _handleEventSave(String title, String description, DateTime date, TimeOfDay? time) {
    // TODO: 実際の保存処理を実装
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('予定を保存しました')),
    );
  }

  void _handleEventTap(Event event) {
    // TODO: イベント詳細画面への遷移を実装
    debugPrint('Event tapped: $event');
  }

  void _showEventsBottomSheet(BuildContext context, DateTime day) {
    final events = _getEventsForDay(day);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return EventBottomSheet(
          selectedDate: day,
          events: events,
          onEventTap: _handleEventTap,
          onEventSave: _handleEventSave,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('スケジュール'),
      ),
      drawer: const HamburgerMenu(),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showEventsBottomSheet(context, selectedDay);
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                final text = DateFormat.E('en_US').format(day);
                if (day.weekday == DateTime.sunday) {
                  return Center(
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (day.weekday == DateTime.saturday) {
                  return Center(
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    text,
                  ),
                );
              },
              defaultBuilder: (context, day, focusedDay) {
                if (day.weekday == DateTime.sunday) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (day.weekday == DateTime.saturday) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  );
                }
                return null;
              },
              outsideBuilder: (context, day, focusedDay) {
                final isSunday = day.weekday == DateTime.sunday;
                final isSaturday = day.weekday == DateTime.saturday;
                final color = isSunday
                    ? Colors.red.withValues(alpha: 0.5)
                    : isSaturday
                        ? Colors.blue.withValues(alpha: 0.5)
                        : Colors.grey.withValues(alpha: 0.5);

                return Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: color),
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                TextStyle? textStyle;
                if (day.weekday == DateTime.sunday) {
                  textStyle = const TextStyle(color: Colors.red);
                } else if (day.weekday == DateTime.saturday) {
                  textStyle = const TextStyle(color: Colors.blue);
                }
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: textStyle,
                    ),
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: _buildEventsMarker(date, events),
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppFooter(),
    );
  }

  Widget _buildEventsMarker(DateTime date, List<Event> events) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        '${events.length}件',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 10.0,
        ),
      ),
    );
  }
}
