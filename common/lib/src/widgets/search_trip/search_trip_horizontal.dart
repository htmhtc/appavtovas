import 'package:common/avtovas_common.dart';
import 'package:common/src/utils/constants/images_assets.dart';
import 'package:common/src/widgets/searchable_menu/searchable_menu.dart';
import 'package:flutter/material.dart';

class SearchTripHorizontal extends StatelessWidget {
  final List<String> items;
  final FocusNode? departureFocusNode;
  final FocusNode? arrivalFocusNode;
  final TextEditingController departureController;
  final TextEditingController arrivalController;
  final ValueChanged onChangedArrival;
  final ValueChanged onChangedDeparture;
  final VoidCallback onSwapButtonTap;
  final Color? fillColor;

  const SearchTripHorizontal({
    required this.items,
    required this.arrivalController,
    required this.departureController,
    required this.onChangedArrival,
    required this.onChangedDeparture,
    required this.onSwapButtonTap,
    this.departureFocusNode,
    this.arrivalFocusNode,
    this.fillColor,
    super.key,
  });

  void _onSwap() {
    final temp = departureController.text;

    departureController.text = arrivalController.text;
    arrivalController.text = temp;

    onSwapButtonTap();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: SearchableMenu(
                focusNode: departureFocusNode,
                controller: departureController,
                items: items,
                onChanged: onChangedDeparture,
                hintText: context.locale.from,
                fillColor: fillColor,
              ),
            ),
            const SizedBox(width: CommonDimensions.large),
            Expanded(
              child: SearchableMenu(
                focusNode: arrivalFocusNode,
                controller: arrivalController,
                items: items,
                onChanged: onChangedArrival,
                hintText: context.locale.to,
                fillColor: fillColor,
              ),
            ),
          ],
        ),
        Align(
          child: Padding(
            padding:
                const EdgeInsets.only(top: CommonDimensions.extraSmall + 1),
            child: FloatingActionButton.small(
              backgroundColor: context.theme.containerBackgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(CommonDimensions.extraLarge),
                ),
              ),
              onPressed: _onSwap,
              child: const AvtovasVectorImage(
                svgAssetPath: ImagesAssets.horizontalSwapIcon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
