
import 'package:common/avtovas_common.dart';
import 'package:common/src/widgets/utils_widgets/selectable_overlay.dart';
import 'package:flutter/material.dart';

final class PassengerCitizenshipSheet extends StatelessWidget {
  final ValueChanged<String> onCitizenshipChanged;
  final String selectedCountry;

  const PassengerCitizenshipSheet({
    required this.onCitizenshipChanged,
    required this.selectedCountry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final countries = Countries.countries(context);

    return SelectableOverlay<String>(
      separatedIndex: 8,
      needScroll: true,
      items: [
        for (final country in countries)
          SelectableOverlayItem(
            onItemChanged: onCitizenshipChanged,
            itemLabel: country,
            item: country,
            selectedItem: selectedCountry,
          ),
      ],
      withSearchField: true,
    );
  }
}
