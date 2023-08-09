// ignore: implementation_imports
import 'package:avtovas_mobile/src/features/reference_info/widgets/reference_info_item.dart';
import 'package:common/avtovas_common.dart';
// ignore: implementation_imports
import 'package:flutter/material.dart';

class ReferenceInfoPageBody extends StatelessWidget {
  const ReferenceInfoPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: CommonDimensions.small,
        left: CommonDimensions.rootPaddingHorizontal,
        right: CommonDimensions.rootPaddingHorizontal,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HelpInfoItem(
              title: context.locale.whatTripsAreThere,
              content: context.locale.whatTripsAreThereContent,
              onSelected: () {
                // ignore: flutter_style_todos
                // TODO(gleb_dyakov): implementation, 2023/07/28
              },
            ),
            HelpInfoItem(
              title: context.locale.willThereBeATrip,
              content: context.locale.willThereBeATripContent,
              onSelected: () {
                // ignore: flutter_style_todos
                // TODO(gleb_dyakov): implementation, 2023/07/28
              },
            ),
            HelpInfoItem(
              title:
              context.locale.howFarInAdvanceDoYouNeedToBuyATicket,
              content: context
                  .locale.howFarInAdvanceDoYouNeedToBuyATicketContent,
              onSelected: () {
                // ignore: flutter_style_todos
                // TODO(gleb_dyakov): implementation, 2023/07/28
              },
            ),
            HelpInfoItem(
              title: context.locale.howToCalculateTravelTimeAndArrivalTime,
              content: context
                  .locale.howToCalculateTravelTimeAndArrivalTimeContent,
              onSelected: () {
                // ignore: flutter_style_todos
                // TODO(gleb_dyakov): implementation, 2023/07/28
              },
            ),
          ],
        ),
      ),
    );
  }
}