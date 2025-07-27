import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'selection_list_tile.dart';

class DatePickerTile extends StatelessWidget {
  final DateTime? selectedDate;
  final String label;
  final String? placeholder;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?> onDateChanged;
  final bool enabled;

  const DatePickerTile({
    super.key,
    required this.selectedDate,
    required this.label,
    this.placeholder,
    this.firstDate,
    this.lastDate,
    required this.onDateChanged,
    this.enabled = true,
  });

  Future<void> _selectDate(BuildContext context) async {
    if (!enabled) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );
    
    if (picked != null) {
      onDateChanged(picked);
    }
  }

  String get _displayText {
    if (selectedDate != null) {
      return '$label: ${DateFormat('yyyy年M月d日(E)', 'ja_JP').format(selectedDate!)}';
    }
    return placeholder ?? '${label}を選択';
  }

  @override
  Widget build(BuildContext context) {
    return SelectionListTile(
      leadingIcon: Icons.calendar_today,
      title: _displayText,
      onTap: enabled ? () => _selectDate(context) : () {},
      showArrow: enabled,
    );
  }
}