import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'common/form_card.dart';
import 'common/form_text_field.dart';
import 'common/location_autocomplete_field.dart';
import 'common/selection_list_tile.dart';
import 'common/form_switch_tile.dart';
import 'common/category_selector.dart';
import 'common/category_management_dialog.dart';

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
  final Function(
          String title, String description, DateTime date, TimeOfDay? time)?
      onEventSave;

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
  final _locationController = TextEditingController();
  final _scrollController = ScrollController();
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedEndTime;
  bool _isRsvpRequired = false;
  DateTime? _rsvpDeadline;
  bool _hasReminder = false;
  int _reminderMinutes = 1440; // デフォルト1日前
  EventCategory? _selectedCategory;
  DateTime? _selectedEventDate;

  // 場所のサジェストリスト
  final List<String> _locationSuggestions = [
    '体育館',
    'グラウンド',
    '野球場',
    'サッカー場',
    'テニスコート',
    'プール',
    '会議室',
    '教室',
  ];

  // デフォルトカテゴリリスト（8個）
  List<EventCategory> _categories = [
    const EventCategory(id: 1, title: '練習', color: Colors.blue),
    const EventCategory(id: 2, title: '試合', color: Colors.red),
    const EventCategory(id: 3, title: 'ミーティング', color: Colors.green),
    const EventCategory(id: 4, title: '合宿', color: Colors.orange),
    const EventCategory(id: 5, title: 'イベント', color: Colors.purple),
    const EventCategory(id: 6, title: '懇親会', color: Colors.pink),
    const EventCategory(id: 7, title: 'トレーニング', color: Colors.teal),
    const EventCategory(id: 8, title: 'その他', color: Colors.grey),
  ];

  @override
  void initState() {
    super.initState();
    _selectedEventDate = widget.selectedDate; // 初期値として設定
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// ダイアログ表示時のフォーカス・スクロール位置管理共通処理
  Future<T?> _showDialogWithScrollPreservation<T>(
    Future<T?> Function() dialogFunction,
  ) async {
    // ダイアログ表示前の準備
    FocusScope.of(context).unfocus();
    final currentScrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    
    // ダイアログ表示
    final result = await dialogFunction();
    
    // ダイアログ終了後の復元処理
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          currentScrollOffset,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      }
    });
    
    return result;
  }

  /// 日付選択ダイアログ表示の共通処理
  Future<void> _selectDate({
    required DateTime? currentDate,
    required String title,
    DateTime? firstDate,
    DateTime? lastDate,
    required Function(DateTime?) onDateChanged,
  }) async {
    final DateTime? picked = await _showDialogWithScrollPreservation(() =>
      showDatePicker(
        context: context,
        initialDate: currentDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2100),
      ),
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await _showDialogWithScrollPreservation(() => 
      showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? picked = await _showDialogWithScrollPreservation(() => 
      showTimePicker(
        context: context,
        initialTime: _selectedEndTime ?? TimeOfDay.now(),
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedEndTime = picked;
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
    _locationController.clear();
    setState(() {
      _selectedTime = null;
      _selectedEndTime = null;
      _isRsvpRequired = false;
      _rsvpDeadline = null;
      _hasReminder = false;
      _reminderMinutes = 1440;
      _selectedCategory = null;
      _selectedEventDate = widget.selectedDate; // 初期値にリセット
      _showAddEventForm = false;
    });
    Navigator.of(context).pop(); // ボトムシートを閉じる
  }

  void _cancelAddEvent() {
    _titleController.clear();
    _descriptionController.clear();
    _locationController.clear();
    setState(() {
      _selectedTime = null;
      _selectedEndTime = null;
      _isRsvpRequired = false;
      _rsvpDeadline = null;
      _hasReminder = false;
      _reminderMinutes = 1440;
      _selectedCategory = null;
      _selectedEventDate = widget.selectedDate; // 初期値にリセット
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
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // 基本情報カード
                FormCard(
                  title: '基本情報',
                  children: [
                    FormTextField(
                      controller: _titleController,
                      labelText: 'タイトル',
                      isRequired: true,
                      maxLength: 50,
                    ),
                    const SizedBox(height: 16),
                    FormTextField(
                      controller: _descriptionController,
                      labelText: '詳細',
                      maxLines: 3,
                      maxLength: 200,
                    ),
                    const SizedBox(height: 16),
                    LocationAutocompleteField(
                      controller: _locationController,
                      suggestions: _locationSuggestions,
                    ),
                    const SizedBox(height: 16),
                    CategorySelector(
                      selectedCategory: _selectedCategory,
                      categories: _categories,
                      onCategoryChanged: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      onManageCategories: _showCategoryManagement,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 日時設定カード
                FormCard(
                  title: '日時設定',
                  children: [
                    SelectionListTile(
                      leadingIcon: Icons.calendar_today,
                      title: _selectedEventDate != null
                          ? 'イベント日: ${DateFormat('yyyy年M月d日(E)', 'ja_JP').format(_selectedEventDate!)}'
                          : 'イベント日を選択',
                      onTap: () => _selectDate(
                        currentDate: _selectedEventDate,
                        title: 'イベント日',
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        onDateChanged: (date) {
                          setState(() {
                            _selectedEventDate = date;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    SelectionListTile(
                      leadingIcon: Icons.access_time,
                      title: _selectedTime != null
                          ? '開始: ${_selectedTime!.format(context)}'
                          : '開始時間を選択（任意）',
                      onTap: _selectTime,
                    ),
                    const Divider(),
                    SelectionListTile(
                      leadingIcon: Icons.access_time_filled,
                      title: _selectedEndTime != null
                          ? '終了: ${_selectedEndTime!.format(context)}'
                          : '終了時間を選択（任意）',
                      onTap: _selectEndTime,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 出欠確認設定カード
                FormCard(
                  title: '出欠確認設定',
                  children: [
                    FormSwitchTile(
                      title: '出欠確認を行う',
                      value: _isRsvpRequired,
                      onChanged: (value) {
                        setState(() {
                          _isRsvpRequired = value;
                        });
                      },
                    ),
                    if (_isRsvpRequired) ...[
                      const Divider(),
                      SelectionListTile(
                        leadingIcon: Icons.calendar_today,
                        title: _rsvpDeadline != null
                            ? '回答期限: ${DateFormat('yyyy年M月d日(E)', 'ja_JP').format(_rsvpDeadline!)}'
                            : '回答期限を選択',
                        onTap: () => _selectDate(
                          currentDate: _rsvpDeadline,
                          title: '回答期限',
                          firstDate: DateTime.now(),
                          lastDate: _selectedEventDate ?? DateTime.now().add(const Duration(days: 365)),
                          onDateChanged: (date) {
                            setState(() {
                              _rsvpDeadline = date;
                            });
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                // リマインダー設定カード
                FormCard(
                  title: 'リマインダー設定',
                  children: [
                    FormSwitchTile(
                      title: 'リマインダーを設定',
                      value: _hasReminder,
                      onChanged: (value) {
                        setState(() {
                          _hasReminder = value;
                        });
                      },
                    ),
                    if (_hasReminder) ...[
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.schedule),
                        title: const Text('通知タイミング'),
                        subtitle: Text(_getReminderText(_reminderMinutes)),
                        trailing: DropdownButton<int>(
                          value: _reminderMinutes,
                          items: const [
                            DropdownMenuItem(value: 15, child: Text('15分前')),
                            DropdownMenuItem(value: 30, child: Text('30分前')),
                            DropdownMenuItem(value: 60, child: Text('1時間前')),
                            DropdownMenuItem(value: 360, child: Text('6時間前')),
                            DropdownMenuItem(value: 720, child: Text('12時間前')),
                            DropdownMenuItem(value: 1440, child: Text('1日前')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _reminderMinutes = value!;
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16), // 最下部にスペースを追加
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCategoryManagement() {
    showDialog(
      context: context,
      builder: (context) => CategoryManagementDialog(
        categories: _categories,
        onCategoriesChanged: (updatedCategories) {
          setState(() {
            _categories = updatedCategories;
          });
        },
      ),
    );
  }

  String _getReminderText(int minutes) {
    switch (minutes) {
      case 15:
        return '15分前';
      case 30:
        return '30分前';
      case 60:
        return '1時間前';
      case 360:
        return '6時間前';
      case 720:
        return '12時間前';
      case 1440:
        return '1日前';
      default:
        return '$minutes分前';
    }
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
    Function(String title, String description, DateTime date, TimeOfDay? time)?
        onEventSave,
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
