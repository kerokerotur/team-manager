import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/form_card.dart';
import '../common/form_switch_tile.dart';
import '../common/selection_list_tile.dart';

class RsvpCard extends StatelessWidget {
  final bool isRsvpRequired;
  final DateTime? rsvpDeadline;
  final ValueChanged<bool> onRsvpToggle;
  final VoidCallback onSelectDeadline;

  const RsvpCard({
    super.key,
    required this.isRsvpRequired,
    required this.rsvpDeadline,
    required this.onRsvpToggle,
    required this.onSelectDeadline,
  });

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: '出欠確認設定',
      children: [
        FormSwitchTile(
          title: '出欠確認を行う',
          value: isRsvpRequired,
          onChanged: onRsvpToggle,
        ),
        if (isRsvpRequired) ...[
          const Divider(),
          SelectionListTile(
            leadingIcon: Icons.calendar_today,
            title: rsvpDeadline != null
                ? '締切: ${DateFormat('yyyy年M月d日(E)', 'ja_JP').format(rsvpDeadline!)}'
                : '回答期限を選択',
            onTap: onSelectDeadline,
          ),
        ],
      ],
    );
  }
}