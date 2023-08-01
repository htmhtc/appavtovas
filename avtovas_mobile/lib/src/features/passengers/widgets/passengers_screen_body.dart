// ignore_for_file: implementation_imports,
import 'package:common/src/utils/constants/common_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common/src/widgets/avtovas_passengers_item/passengers_item.dart';

class PassengersScreenBody extends StatelessWidget {
  const PassengersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: CommonDimensions.passengerListPaddingHorizontal,
      ),
      children: List.generate(
        15,
        (index) => PassengersItem(
          name: 'w',
          age: '3',
          gender: 'a',
          onSelected: () {},
        ),
      ),
    );
  }
}
