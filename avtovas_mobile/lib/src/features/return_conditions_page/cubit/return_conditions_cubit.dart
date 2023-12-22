import 'package:avtovas_mobile/src/common/widgets/base_navigation_page/utils/route_helper.dart';
import 'package:common/avtovas_navigation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'return_conditions_state.dart';

class ReturnConditionsCubit extends Cubit<ReturnConditionsState> {
  ReturnConditionsCubit()
      : super(
          const ReturnConditionsState(
            route: CustomRoute(null, null),
          ),
        );

  void onBackButtonTap() {
    emit(
      state.copyWith(
        route: const CustomRoute.pop(),
      ),
    );
  }

  void onNavigationItemTap(int navigationIndex) {
    emit(
      state.copyWith(
        route: RouteHelper.clearedRoute(navigationIndex),
      ),
    );

    emit(
      state.copyWith(
        route: const CustomRoute(null, null),
      ),
    );
  }
}
