import 'package:flutter/material.dart';
import 'category_selector.dart';

class CategoryManagementDialog extends StatefulWidget {
  final List<EventCategory> categories;
  final Function(List<EventCategory>) onCategoriesChanged;

  const CategoryManagementDialog({
    super.key,
    required this.categories,
    required this.onCategoriesChanged,
  });

  @override
  State<CategoryManagementDialog> createState() => _CategoryManagementDialogState();
}

class _CategoryManagementDialogState extends State<CategoryManagementDialog> {
  late List<EventCategory> _categories;
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _categories = List.from(widget.categories);
    for (final category in _categories) {
      _controllers[category.id] = TextEditingController(text: category.title);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveChanges() {
    final updatedCategories = _categories.map((category) {
      final newTitle = _controllers[category.id]?.text.trim() ?? category.title;
      return category.copyWith(title: newTitle.isEmpty ? category.title : newTitle);
    }).toList();

    widget.onCategoriesChanged(updatedCategories);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('カテゴリ管理'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: category.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _controllers[category.id],
                      decoration: InputDecoration(
                        labelText: 'カテゴリ${index + 1}',
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      maxLength: 20,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _saveChanges,
          child: const Text('保存'),
        ),
      ],
    );
  }
}