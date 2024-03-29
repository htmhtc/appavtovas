import 'package:avtovas_mobile/src/common/constants/app_dimensions.dart';
import 'package:common/avtovas_common.dart';
import 'package:flutter/material.dart';

class TicketingShimmerContent extends StatelessWidget {
  const TicketingShimmerContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const firstShimmerHeight = 110.0;
    const secondShimmerHeight = 600.0;
    const thirdShimmerHeight = 170.0;
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.large),
      children: const <Widget>[
        BaseShimmer(
          margin: EdgeInsets.zero,
          shimmerWidth: double.maxFinite,
          shimmerHeight: firstShimmerHeight,
        ),
        BaseShimmer(
          margin: EdgeInsets.zero,
          shimmerWidth: double.maxFinite,
          shimmerHeight: secondShimmerHeight,
        ),
        BaseShimmer(
          margin: EdgeInsets.zero,
          shimmerWidth: double.maxFinite,
          shimmerHeight: thirdShimmerHeight,
        ),
      ].insertBetween(
        const SizedBox(height: AppDimensions.large),
      ),
    );
  }
}
