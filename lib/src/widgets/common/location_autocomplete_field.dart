import 'package:flutter/material.dart';

class LocationAutocompleteField extends StatelessWidget {
  final TextEditingController controller;
  final List<String>? suggestions;
  final String labelText;
  final int? maxLength;

  const LocationAutocompleteField({
    super.key,
    required this.controller,
    this.suggestions,
    this.labelText = '場所',
    this.maxLength = 100,
  });

  /// デフォルト場所サジェストリスト - ウィジェット側で管理
  static const List<String> defaultSuggestions = [
    '体育館',
    'グラウンド',
    '野球場',
    'サッカー場',
    'テニスコート',
    'プール',
    '会議室',
    '教室',
  ];

  List<String> get _effectiveSuggestions => suggestions ?? defaultSuggestions;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _effectiveSuggestions.where((String option) {
          return option.contains(textEditingValue.text);
        });
      },
      onSelected: (String selection) {
        controller.text = selection;
      },
      fieldViewBuilder: (context, fieldController, focusNode, onEditingComplete) {
        controller.text = fieldController.text;
        return TextField(
          controller: fieldController,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.location_on),
          ),
          maxLength: maxLength,
        );
      },
    );
  }
}