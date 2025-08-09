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
  final ScrollController? scrollController;

  const DatePickerTile({
    super.key,
    required this.selectedDate,
    required this.label,
    this.placeholder,
    this.firstDate,
    this.lastDate,
    required this.onDateChanged,
    this.enabled = true,
    this.scrollController,
  });

  Future<void> _selectDate(BuildContext context) async {
    if (!enabled) return;

    // ダイアログ表示前の準備（フォーカス・スクロール位置保持）
    FocusScope.of(context).unfocus();
    final currentScrollOffset = scrollController?.hasClients == true ? scrollController!.offset : 0.0;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );
    
    if (picked != null) {
      onDateChanged(picked);
    }

    // ダイアログ終了後の復元処理
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
      if (scrollController?.hasClients == true) {
        scrollController!.animateTo(
          currentScrollOffset,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      }
    });
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