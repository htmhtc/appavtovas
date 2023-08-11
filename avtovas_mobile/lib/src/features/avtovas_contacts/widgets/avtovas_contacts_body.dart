import 'package:avtovas_mobile/src/common/constants/app_assets.dart';
import 'package:avtovas_mobile/src/common/constants/app_dimensions.dart';
import 'package:avtovas_mobile/src/features/avtovas_contacts/widgets/avtovas_contacts_info_section.dart';
import 'package:avtovas_mobile/src/features/avtovas_contacts/widgets/question_form.dart';
import 'package:avtovas_mobile/src/features/avtovas_contacts/widgets/section_tile.dart';
import 'package:common/avtovas_common_localization.dart';
import 'package:common/avtovas_common_themes.dart';
import 'package:flutter/material.dart';

final class AvtovasContactsBody extends StatelessWidget {
  const AvtovasContactsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themePath = context.themeData.textTheme;
    final localePath = context.locale;

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.large,
        vertical: AppDimensions.large,
      ),
      children: [
        AvtovasContactsInfoSection(
          title: localePath.technicalSupportService,
          firstSvgPath: AppAssets.phoneIcon,
          secondSvgPath: AppAssets.twentyFourHoursIcon,
          firstLabel: '8 (800) 700 - 02 - 40',
          secondLabel: localePath.twentyFourHours,
        ),
        const SizedBox(height: AppDimensions.extraLarge),
        AvtovasContactsInfoSection(
          title: localePath.centralBusStationHelpline,
          firstSvgPath: AppAssets.phoneIcon,
          secondSvgPath: AppAssets.calendarIcon,
          firstLabel: '+7 (8352) 28-90-00',
          secondLabel: localePath.dailyFromFiveToTwenty,
        ),
        const SizedBox(height: AppDimensions.extraLarge),
        SectionTitle(title: localePath.askQuestion),
        const SizedBox(height: AppDimensions.large),
        Text(
          localePath.ourQualifiedExpertsWillHelp,
          style: themePath.titleLarge,
        ),
        const SizedBox(height: AppDimensions.extraLarge),
        QuestionForm(
          nameOnChanged: (value) {},
          emailOnChanged: (value) {},
          phoneOnChanged: (value) {},
          questionOnChanged: (value) {},
          onTap: () {},
        ),
      ],
    );
  }
}