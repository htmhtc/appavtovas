import 'package:common/avtovas_common.dart';
import 'package:common/src/utils/constants/images_assets.dart';
import 'package:common/src/widgets/ticketing/gender_switcher.dart';
import 'package:common/src/widgets/ticketing/ticketing_container.dart';
import 'package:common/src/widgets/utils_widgets/avtovas_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

// ignore_for_file: avoid-non-ascii-symbols

final class PassengerCollapsedContainer extends StatefulWidget {
  final Widget countriesMenu;
  final Widget documentsMenu;
  final Widget ratesMenu;
  final Widget placesMenu;
  final ValueChanged<Genders> onGenderChanged;
  final ValueChanged<bool?> onSurnameVisibleChanged;
  final Genders selectedGender;
  final bool isSurnameVisible;

  const PassengerCollapsedContainer({
    required this.countriesMenu,
    required this.documentsMenu,
    required this.ratesMenu,
    required this.placesMenu,
    required this.onGenderChanged,
    required this.onSurnameVisibleChanged,
    required this.isSurnameVisible,
    required this.selectedGender,
    super.key,
  });

  @override
  State<PassengerCollapsedContainer> createState() =>
      _PassengerCollapsedContainerState();
}

class _PassengerCollapsedContainerState
    extends State<PassengerCollapsedContainer> {
  late final MaskedTextController _dateController;

  @override
  void initState() {
    super.initState();

    _dateController = MaskedTextController(mask: '00.00.0000');
  }

  @override
  Widget build(BuildContext context) {
    return TicketingContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                context.locale.passengerAmount(1),
                style: context.themeData.textTheme.titleLarge?.copyWith(
                  fontSize: CommonFonts.sizeHeadlineMedium,
                ),
              ),
              const Spacer(),
              AvtovasButton.icon(
                buttonText: context.locale.selectPassenger,
                backgroundOpacity: 0,
                textStyle: context.themeData.textTheme.titleLarge?.copyWith(
                  color: context.theme.primaryTextColor,
                ),
                svgPath: ImagesAssets.passengerSmallIcon,
                buttonColor: context.theme.transparent,
                onTap: () {},
              ),
            ],
          ),
          InputField(
            hintText: context.locale.firstName,
            fieldTitle: context.locale.firstName,
          ),
          InputField(
            hintText: context.locale.lastName,
            fieldTitle: context.locale.lastName,
          ),
          AnimatedSizedBox(
            toHeight: widget.isSurnameVisible ? CommonDimensions.none : null,
            child: InputField(
              hintText: context.locale.surname,
              fieldTitle: context.locale.surname,
            ),
          ),
          AvtovasCheckbox(
            onChanged: widget.onSurnameVisibleChanged,
            value: widget.isSurnameVisible,
            checkboxText: context.locale.noSurname,
          ),
          GenderSwitcher(
            onGenderChanged: widget.onGenderChanged,
            selectedGender: widget.selectedGender,
          ),
          InputField(
            controller: _dateController,
            fieldTitle: context.locale.birthdayDate,
            keyboardType: TextInputType.datetime,
            hintText: '__.__.____',
          ),
          widget.countriesMenu,
          widget.documentsMenu,
          InputField(
            fieldTitle: context.locale.seriesAndNumber,
            onChanged: (value) {},
          ),
          widget.ratesMenu,
          widget.placesMenu,
          Divider(color: context.theme.dividerColor),
          const SizedBox(height: CommonDimensions.small),
          Row(
            children: [
              Text(
                context.locale.priceByRate,
                style: context.themeData.textTheme.titleLarge,
              ),
              const Spacer(),
              // TODO(dev): Use model instead.
              Text(
                '1200,00 руб.',
                style: context.themeData.textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: CommonDimensions.small),
          Divider(color: context.theme.dividerColor),
          const SizedBox(height: CommonDimensions.small),
          Row(
            children: [
              Text(
                context.locale.total,
                style: context.themeData.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                // TODO(dev): Use model instead.
                '1200,00 руб.',
                style: context.themeData.textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: CommonDimensions.small),
        ].insertBetween(
          const SizedBox(height: CommonDimensions.medium),
        ),
      ),
    );
  }
}