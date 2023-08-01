import 'package:common/src/widgets/input_field/input_field.dart';
import 'package:flutter/material.dart';

final class PhoneInputField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ValueChanged<String> onPhoneChanged;

  const PhoneInputField({
    required this.onPhoneChanged,
    required this.formKey,
    super.key,
  });

  String? _validator(String? value) {
    if (value == null || value.isEmpty) return 'Некорректное значение';

    final cleanedPhoneNumber = value.replaceAll(RegExp(r'\D'), '');

    final isNumberValid =
        RegExp(r'(^8|7|\+7)((\d{10})|(\s\(\d{3}\)\s\d{3}\s\d{2}\s\d{2}))')
            .hasMatch(cleanedPhoneNumber);

    return isNumberValid ? null : 'Некорректное значение';
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      formKey: formKey,
      keyboardType: TextInputType.phone,
      validator: _validator,
      hintText: '+7 (999) 123-45-67',
    );
  }
}
