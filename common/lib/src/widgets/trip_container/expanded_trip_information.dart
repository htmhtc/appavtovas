import 'package:common/avtovas_common.dart';
import 'package:common/src/utils/constants/common_dimensions.dart';
import 'package:flutter/material.dart';

final class ExpandedTripInformation extends StatelessWidget {
  final String ticketPrice;
  final String freePlaces;
  final bool isSmart;
  final VoidCallback onBuyTap;

  const ExpandedTripInformation({
    required this.ticketPrice,
    required this.freePlaces,
    required this.isSmart,
    required this.onBuyTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buyTicket = context.locale.buyTicket;

    return !isSmart
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TicketPriceText(ticketPrice: ticketPrice),
              _FreePlacesBody(freePlaces: freePlaces),
              const SizedBox(
                height:
                    CommonDimensions.extraLarge + CommonDimensions.extraSmall,
              ),
              AvtovasBuyButton(
                buttonText: buyTicket,
                onTap: onBuyTap,
              ),
            ],
          )
        : Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TicketPriceText(ticketPrice: ticketPrice),
                  _FreePlacesBody(freePlaces: freePlaces),
                ],
              ),
              const Spacer(),
              AvtovasBuyButton(
                buttonText: buyTicket,
                onTap: onBuyTap,
              ),
            ],
          );
  }
}

final class _TicketPriceText extends StatelessWidget {
  final String ticketPrice;

  const _TicketPriceText({required this.ticketPrice});

  @override
  Widget build(BuildContext context) {
    return Text(
      ticketPrice,
      style: context.themeData.textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

final class _FreePlacesBody extends StatelessWidget {
  final String freePlaces;

  const _FreePlacesBody({
    required this.freePlaces,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.themeData.textTheme.bodyLarge;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: context.locale.placesLeft,
            style: textTheme,
          ),
          TextSpan(
            text: context.locale.freePlaces(int.parse(freePlaces)),
            style: textTheme?.copyWith(
              color: context.theme.mainAppColor,
            ),
          ),
        ],
      ),
    );
  }
}