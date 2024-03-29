import 'dart:async';

import 'package:avtovas_web/src/common/constants/app_dimensions.dart';
import 'package:avtovas_web/src/common/constants/web_assets.dart';
import 'package:avtovas_web/src/common/constants/web_fonts.dart';
import 'package:common/avtovas_common.dart';
import 'package:common/avtovas_utils_widgets.dart';
import 'package:core/avtovas_core.dart';
import 'package:flutter/material.dart';

class MyBookedTrip extends StatefulWidget {
  final StatusedTrip trip;
  final int bookingTimer;
  final ValueSetter<String> onTimerEnd;
  final VoidCallback onPayTap;
  final VoidCallback tripRemoveCallback;

  const MyBookedTrip({
    required this.trip,
    required this.bookingTimer,
    required this.onTimerEnd,
    required this.onPayTap,
    required this.tripRemoveCallback,
    super.key,
  });

  @override
  State<MyBookedTrip> createState() => _MyBookedTripState();
}

class _MyBookedTripState extends State<MyBookedTrip> {
  // ignore: unused_element
  Future<void> _showPaymentBottomSheet({
    required BuildContext context,
    required String ticketPrice,
    required String tariffValue,
    required String commissionValue,
    required String totalValue,
    required VoidCallback payCallback,
    required VoidCallback payByCardCallback,
  }) {
    return SupportMethods.showAvtovasBottomSheet(
      context: context,
      sheetTitle: context.locale.orderPayment,
      child: Material(
        child: MyTripPaymentContent(
          ticketPrice: ticketPrice,
          tariffValue: tariffValue,
          commissionValue: commissionValue,
          totalValue: totalValue,
          payCallback: payCallback,
          payByCardCallback: payByCardCallback,
        ),
      ),
    );
  }

  Future<void> _showDeleteAlert({
    required BuildContext context,
    required VoidCallback okayCallback,
  }) {
    return SupportMethods.showAvtovasDialog(
      context: context,
      builder: (context) => AvtovasAlertDialog(
        title: context.locale.confirmOrderDeletion,
        okayCallback: okayCallback,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainColorTextStyle = context.themeData.textTheme.titleLarge?.copyWith(
      color: context.theme.mainAppColor,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AvtovasPlatform.isWeb
            ? context.theme.containerBackgroundColor
            : context.theme.detailsBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppDimensions.medium,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyTripOrderNumberText(
              orderNumber: context.locale.orderNum + widget.trip.trip.routeNum,
            ),
            MyTripBookingTimer(
              bookingTimer: widget.bookingTimer.toString().formatSeconds(),
            ),
            MyTripStatusRow(
              statusWidgets: [
                const AvtovasVectorImage(svgAssetPath: WebAssets.warningIcon),
                Text(
                  context.locale.awaitingPayment,
                  style: context.themeData.textTheme.headlineMedium?.copyWith(
                    fontWeight: WebFonts.weightRegular,
                    color: context.theme.paymentPendingColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.small),
            MyTripDetails(
              arrivalDateTime: widget.trip.trip.arrivalTime,
              departureDateTime: widget.trip.trip.departureTime,
              arrivalAddress: widget.trip.trip.destination.address ?? '',
              departureAddress: widget.trip.trip.departure.address ?? '',
              departurePlace: widget.trip.trip.departure.name,
              arrivalPlace: widget.trip.trip.destination.name,
              timeInRoad: widget.trip.trip.duration.formatDuration(),
            ),
            MyTripSeatAndPriceRow(
              numberOfSeats: widget.trip.places.join(', '),
              ticketPrice: context.locale.price(widget.trip.saleCost),
            ),
            const SizedBox(height: AppDimensions.large),
            MyTripChildren(
              children: [
                AvtovasButton.text(
                  padding: const EdgeInsets.all(AppDimensions.large),
                  buttonText: '${context.locale.pay} '
                      '${context.locale.price(widget.trip.saleCost)}',
                  onTap: widget.onPayTap,
                ),
                AvtovasButton.icon(
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: const EdgeInsets.all(AppDimensions.large),
                  svgPath: WebAssets.deleteIcon,
                  buttonColor: context.theme.detailsBackgroundColor,
                  borderColor: context.theme.mainAppColor,
                  buttonText: context.locale.deleteOrder,
                  textStyle: mainColorTextStyle,
                  onTap: () => _showDeleteAlert(
                    context: context,
                    okayCallback: widget.tripRemoveCallback,
                  ),
                ),
              ],
            ),
          ].insertBetween(
            const SizedBox(
              height: AppDimensions.small,
            ),
          ),
        ),
      ),
    );
  }
}
