import 'package:avtovas_web/src/common/constants/app_dimensions.dart';
import 'package:avtovas_web/src/common/constants/web_fonts.dart';
import 'package:common/avtovas_common.dart';
import 'package:flutter/material.dart';

class TermsPrivacyPolicyBody extends StatelessWidget {
  final bool smartLayout;
  const TermsPrivacyPolicyBody({
    required this.smartLayout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            smartLayout ? AppDimensions.large : AppDimensions.extraLarge,
        vertical: smartLayout ? AppDimensions.large : AppDimensions.extraLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.locale.privacyPolicy,
            style: context.themeData.textTheme.displayMedium?.copyWith(),
          ),
          Text(
            context.locale.privacyPolicyText,
            style: context.themeData.textTheme.titleLarge?.copyWith(
              fontSize: WebFonts.sizeHeadlineMedium,
              fontWeight: WebFonts.weightRegular,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: AppDimensions.large,
          //   ),
          //   child: Text(
          //     context.locale.additionalPrecautions,
          //   ),
          // ),
          // Text(
          //   context.locale.methodsAndTermsOfPersonalDataProcessing,
          //   style: context.themeData.textTheme.titleLarge?.copyWith(
          //     fontSize: WebFonts.sizeHeadlineMedium,
          //     fontWeight: WebFonts.weightRegular,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: AppDimensions.large,
          //   ),
          //   child: Text(
          //     context.locale.personalDataProcessingDesc,
          //   ),
          // ),
        ],
      ),
    );
  }
}
