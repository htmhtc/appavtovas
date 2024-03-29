import 'package:common/src/theme/theme_extension.dart';
import 'package:common/src/utils/constants/common_dimensions.dart';
import 'package:flutter/material.dart';

final class AvtovasCheckbox extends StatelessWidget {
  final ValueChanged<bool?> onChanged;
  final bool value;
  final String? checkboxText;
  final TextStyle? textStyle;

  const AvtovasCheckbox({
    required this.onChanged,
    required this.value,
    this.checkboxText,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: CommonDimensions.checkBoxSize,
          height: CommonDimensions.checkBoxSize,
          child: Checkbox(
            activeColor: context.theme.mainAppColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(CommonDimensions.small),
              ),
            ),
            side: BorderSide(
              width: CommonDimensions.checkboxBorderWidth,
              color: context.theme.fivefoldTextColor,
            ),
            value: value,
            onChanged: onChanged,
          ),
        ),
        if (checkboxText != null) ...[
          const SizedBox(width: CommonDimensions.medium),
          Flexible(
            child: Text(checkboxText!, style: textStyle,
              overflow: TextOverflow.ellipsis,),
          ),
        ],
      ],
    );
  }
}
