// ignore_for_file: implementation_imports,
import 'package:avtovas_mobile/src/common/constants/app_dimensions.dart';
import 'package:avtovas_mobile/src/common/cubit_scope/cubit_scope.dart';
import 'package:avtovas_mobile/src/common/di/injector.dart';
import 'package:avtovas_mobile/src/common/utils/mocks.dart';
import 'package:avtovas_mobile/src/features/passengers/cubit/passengers_cubit.dart';
import 'package:common/avtovas_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class PassengersScreenBody extends StatefulWidget {
  const PassengersScreenBody({super.key});

  @override
  State<PassengersScreenBody> createState() => _PassengersScreenBodyState();
}

class _PassengersScreenBodyState extends State<PassengersScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassengersCubit, PassengersState>(
      builder: (context, state) {
        final passengersCubit = CubitScope.of<PassengersCubit>(context);
        passengersCubit.setPassengers(Mocks.passengers);
        return ListView.builder(
          itemCount: passengersCubit.state.passengers.length,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.large,
          ),
          itemBuilder: (BuildContext context, int index) {
            return PassengersItem(
              name: passengersCubit.state.passengers[index].fullName,
              age: '${passengersCubit.state.passengers[index].age}',
              gender: passengersCubit.state.passengers[index].gender,
              onSelected: () {},
            );
          },
        );
      },
    );
  }
}