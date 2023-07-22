
import 'package:common/src/widgets/input_field/input_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: unnecessary_statements


/// TextField in SearchableMenu is taken from InputField.
///
/// how to use:
///
/// ```dart
/// SearchableMenu(
/// items: ['Item 1' , Item 2' , Item 3'],
/// hintText: 'Search items...'
/// )
/// ```
class SearchableMenu extends StatelessWidget {
  final String hintText;
  final List<String> items;
  const SearchableMenu({
    required this.hintText,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              InputField(
        controller: textEditingController,
        hintText: hintText,
        focusNode: focusNode,
      ),
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text == '') items;
        return items.where(
          (String option) => option.contains(textEditingValue.text),
        );
      },
    );
  }
}