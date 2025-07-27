import 'package:flutter/material.dart';
import '../common/form_card.dart';
import '../common/form_switch_tile.dart';

class ReminderCard extends StatelessWidget {
  final bool hasReminder;
  final int reminderMinutes;
  final ValueChanged<bool> onReminderToggle;
  final ValueChanged<int> onReminderMinutesChanged;

  const ReminderCard({
    super.key,
    required this.hasReminder,
    required this.reminderMinutes,
    required this.onReminderToggle,
    required this.onReminderMinutesChanged,
  });

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
    return FormCard(
      title: 'リマインダー設定',
      children: [
        FormSwitchTile(
          title: 'リマインダーを設定',
          value: hasReminder,
          onChanged: onReminderToggle,
        ),
        if (hasReminder) ...[
          const Divider(),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('通知タイミング'),
            subtitle: Text(_getReminderText(reminderMinutes)),
            trailing: DropdownButton<int>(
              value: reminderMinutes,
              items: const [
                DropdownMenuItem(value: 15, child: Text('15分前')),
                DropdownMenuItem(value: 30, child: Text('30分前')),
                DropdownMenuItem(value: 60, child: Text('1時間前')),
                DropdownMenuItem(value: 360, child: Text('6時間前')),
                DropdownMenuItem(value: 720, child: Text('12時間前')),
                DropdownMenuItem(value: 1440, child: Text('1日前')),
              ],
              onChanged: (value) {
                if (value != null) {
                  onReminderMinutesChanged(value);
                }
              },
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ],
    );
  }
}