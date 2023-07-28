import 'package:common/avtovas_common.dart';
import 'package:flutter/material.dart';

class UpcomingTrips extends StatelessWidget {
  final MockTrip mockTrip;
  final List<String> trips;
  const UpcomingTrips({
    required this.mockTrip,
    required this.trips,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return Center(
        child: Text(
          context.locale.noUpcomingTrips,
          style: context.themeData.textTheme.displayMedium?.copyWith(
            color: context.theme.fivefoldTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else if (trips.isNotEmpty) {
      return Center(
        child: Text(
          'WILL BE ADDED SOON',
          style: context.themeData.textTheme.displayMedium?.copyWith(
            color: context.theme.fivefoldTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    return Center(
      child: Text(
        'SMTH WENT WRONG',
        style: context.themeData.textTheme.displayMedium?.copyWith(
          color: context.theme.fivefoldTextColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
