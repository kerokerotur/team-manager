import 'package:flutter/material.dart';

class EventCategory {
  final int id;
  final String title;
  final Color color;

  const EventCategory({
    required this.id,
    required this.title,
    required this.color,
  });

  EventCategory copyWith({
    int? id,
    String? title,
    Color? color,
  }) {
    return EventCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
    );
  }
}

class CategorySelector extends StatelessWidget {
  final EventCategory? selectedCategory;
  final List<EventCategory> categories;
  final ValueChanged<EventCategory?> onCategoryChanged;
  final VoidCallback? onManageCategories;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
    this.onManageCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // カテゴリ選択ドロップダウン
        DropdownButtonFormField<EventCategory?>(
          value: selectedCategory,
          decoration: const InputDecoration(
            labelText: 'カテゴリ',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.category),
          ),
          items: [
            const DropdownMenuItem<EventCategory?>(
              value: null,
              child: Text('カテゴリを選択'),
            ),
            ...categories.map((category) {
              return DropdownMenuItem<EventCategory?>(
                value: category,
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: category.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(category.title),
                  ],
                ),
              );
            }),
          ],
          onChanged: onCategoryChanged,
        ),
        if (onManageCategories != null) ...[
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: onManageCategories,
            icon: const Icon(Icons.edit, size: 16),
            label: const Text('カテゴリを管理'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ],
    );
  }
}