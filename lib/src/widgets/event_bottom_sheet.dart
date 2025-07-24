import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// イベントを表すシンプルなクラス（schedule.dartと共通利用）
class Event {
  final String title;

  Event(this.title);

  @override
  String toString() => title;
}

class EventBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final List<Event> events;
  final Function(Event) onEventTap;
  final Function(String title, String description, DateTime date, TimeOfDay? time)? onEventSave;

  const EventBottomSheet({
    super.key,
    required this.selectedDate,
    required this.events,
    required this.onEventTap,
    this.onEventSave,
  });

  @override
  State<EventBottomSheet> createState() => _EventBottomSheetState();
}

class _EventBottomSheetState extends State<EventBottomSheet> {
  bool _showAddEventForm = false;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveEvent() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('タイトルを入力してください')),
      );
      return;
    }

    // コールバック経由で保存処理を実行
    widget.onEventSave?.call(
      _titleController.text.trim(),
      _descriptionController.text.trim(),
      widget.selectedDate,
      _selectedTime,
    );

    // フォームをリセット
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedTime = null;
      _showAddEventForm = false;
    });
    Navigator.of(context).pop(); // ボトムシートを閉じる
  }

  void _cancelAddEvent() {
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedTime = null;
      _showAddEventForm = false;
    });
  }

  Widget _buildEventsList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('M/d (E)', 'en_US').format(widget.selectedDate),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _showAddEventForm = true;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: widget.events.isEmpty
              ? const Center(child: Text('予定はありません'))
              : ListView.builder(
                  itemCount: widget.events.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => widget.onEventTap(widget.events[index]),
                        title: Text('${widget.events[index]}'),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildAddEventForm() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _cancelAddEvent,
                child: const Text('キャンセル'),
              ),
              const Text(
                '新規イベント',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _saveEvent,
                child: const Text('保存'),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'タイトル *',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 50,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: '詳細',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  maxLength: 200,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '日時設定',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text(
                            DateFormat('yyyy年M月d日(E)', 'ja_JP').format(widget.selectedDate),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // 選択された日付は固定（変更不可）
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text(
                            _selectedTime != null
                                ? _selectedTime!.format(context)
                                : '時間を選択（任意）',
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: _selectTime,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: _showAddEventForm ? _buildAddEventForm() : _buildEventsList(),
    );
  }

  static void show({
    required BuildContext context,
    required DateTime selectedDate,
    required List<Event> events,
    required Function(Event) onEventTap,
    Function(String title, String description, DateTime date, TimeOfDay? time)? onEventSave,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return EventBottomSheet(
          selectedDate: selectedDate,
          events: events,
          onEventTap: onEventTap,
          onEventSave: onEventSave,
        );
      },
    );
  }
}