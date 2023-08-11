import 'package:avtovas_mobile/src/common/cubit_scope/cubit_scope.dart';
import 'package:avtovas_mobile/src/common/widgets/base_navigation_page/base_navigation_page.dart';
import 'package:avtovas_mobile/src/features/passengers/cubit/passengers_cubit.dart';
import 'package:avtovas_mobile/src/features/passengers/widgets/passengers_body.dart';
import 'package:common/avtovas_common_localization.dart';
import 'package:flutter/material.dart';

class PassengersScreen extends StatelessWidget {
  const PassengersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CubitScope<PassengersCubit>(
      child: BaseNavigationPage(
        appBarTitle: context.locale.passengersTitle,
        body: const PassengersBody(),
      ),
    );
  }
}