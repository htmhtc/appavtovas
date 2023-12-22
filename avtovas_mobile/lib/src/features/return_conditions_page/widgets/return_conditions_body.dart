import 'package:avtovas_mobile/src/common/constants/app_dimensions.dart';
import 'package:avtovas_mobile/src/common/constants/app_fonts.dart';
import 'package:common/avtovas_common.dart';
import 'package:flutter/material.dart';

class ReturnConditionsBody extends StatelessWidget {
  const ReturnConditionsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.large),
      shrinkWrap: true,
      children: [
        Text(
          context.locale.returnConditions,
          style: context.themeData.textTheme.displayMedium,
        ),
        const SizedBox(
          height: AppDimensions.medium,
        ),
        Text(
          context.locale.cancellationOrDelay,
          style: context.themeData.textTheme.headlineMedium?.copyWith(
            color: context.theme.quaternaryTextColor,
            fontWeight: AppFonts.weightRegular,
          ),
        ),
        const SizedBox(
          height: AppDimensions.medium,
        ),
        Text(
          context.locale.returnFivePercent,
          style: context.themeData.textTheme.headlineMedium?.copyWith(
            color: context.theme.quaternaryTextColor,
            fontWeight: AppFonts.weightRegular,
          ),
        ),
        const SizedBox(
          height: AppDimensions.medium,
        ),
        Text(
          context.locale.returnFiftheenPercent,
          style: context.themeData.textTheme.headlineMedium?.copyWith(
            color: context.theme.quaternaryTextColor,
            fontWeight: AppFonts.weightRegular,
          ),
        ),
        const SizedBox(
          height: AppDimensions.medium,
        ),
        Text(
          context.locale.returnTwentyFivePercent,
          style: context.themeData.textTheme.headlineMedium?.copyWith(
            color: context.theme.quaternaryTextColor,
            fontWeight: AppFonts.weightRegular,
          ),
        ),
        const SizedBox(
          height: AppDimensions.medium,
        ),
        Text(
          context.locale.returnTwentyFivePercentExcuse,
          style: context.themeData.textTheme.headlineMedium?.copyWith(
            color: context.theme.quaternaryTextColor,
            fontWeight: AppFonts.weightRegular,
          ),
        ),
        const SizedBox(
          height: AppDimensions.medium,
        ),
        Text(
          context.locale.returnNineteenPercent,
          style: context.themeData.textTheme.headlineMedium?.copyWith(
            color: context.theme.quaternaryTextColor,
            fontWeight: AppFonts.weightRegular,
          ),
        ),
        const SizedBox(
          height: AppDimensions.medium,
        ),
        Text(
          context.locale.returnFullPrice,
          style: context.themeData.textTheme.headlineMedium?.copyWith(
            color: context.theme.quaternaryTextColor,
            fontWeight: AppFonts.weightRegular,
          ),
        ),
      ],
    );
  }
}
