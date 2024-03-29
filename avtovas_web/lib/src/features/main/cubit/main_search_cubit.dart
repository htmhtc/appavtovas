import 'dart:async';

import 'package:avtovas_web/src/common/navigation/app_router.dart';
import 'package:avtovas_web/src/common/navigation/routes.dart';
import 'package:common/avtovas_navigation.dart';
import 'package:core/avtovas_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'main_search_state.dart';

class MainSearchCubit extends Cubit<MainSearchState> {
  final SearchInteractor _searchInteractor;

  MainSearchCubit(this._searchInteractor)
      : super(
          const MainSearchState(
            route: CustomRoute(null, null),
            busStops: [],
            suggestions: [],
            destinationsSuggestions: [],
            searchHistory: [],
          ),
        ) {
    _subscribeAll();
  }

  GoRouter get _appRouter => AppRouter.appRouter;

  StreamSubscription<User>? _userSubscription;
  StreamSubscription<List<BusStop>?>? _busStopsSubscription;

  void _subscribeAll() {
    _busStopsSubscription?.cancel();
    _busStopsSubscription =
        _searchInteractor.busStopsStream.listen(_onNewBusStops);

    _userSubscription?.cancel();
    _userSubscription = _searchInteractor.userStream.listen(_onNewUser);
  }

  @override
  Future<void> close() {
    _busStopsSubscription?.cancel();
    _busStopsSubscription = null;

    _userSubscription?.cancel();
    _userSubscription = null;

    return super.close();
  }

  void search(VoidCallback onReset) {
    if (state.departurePlace != null &&
        state.arrivalPlace != null &&
        state.tripDate != null &&
        state.departurePlace!.isNotEmpty &&
        state.arrivalPlace!.isNotEmpty) {
      _searchInteractor.setTripsScheduleArguments(
        lastSearchedDeparture: state.departurePlace!,
        lastSearchArrival: state.arrivalPlace!,
        lastSearchedDate: state.tripDate!,
      );
      _navigateToSchedule();
      _resetMainPage(onReset);
    }
  }

  void _navigateToSchedule() {
    _appRouter.pushNamed(
      Routes.searchTripsPath.name,
      pathParameters: {
        'departure_name': state.departurePlace!,
        'arrival_name': state.arrivalPlace!,
        'trip_date': state.tripDate!.toString(),
      },
    );

    /* _appRouter.navigateTo(
      CustomRoute(
        RouteType.navigateTo,
        tripsScheduleConfig(
          departurePlace: state.departurePlace!,
          arrivalPlace: state.arrivalPlace!,
          tripDate: state.tripDate!,
        ),
      ),
    );*/
  }

  void clearSearchHistory() {
    _searchInteractor.clearSearchHistory();
  }

  void onDepartureChanged(String departurePlace) {
    emit(
      state.copyWith(departurePlace: departurePlace),
    );
  }

  void onArrivalChanged(String arrivalPlace) {
    emit(
      state.copyWith(arrivalPlace: arrivalPlace),
    );
  }

  void setTripDate(DateTime tripDate) {
    emit(
      state.copyWith(tripDate: tripDate),
    );
  }

  void searchByPopularRoute({
    required String departure,
    required String arrival,
    required VoidCallback onReset,
  }) {
    onDepartureChanged(departure);
    onArrivalChanged(arrival);
    setTripDate(DateTime.now());
    search(onReset);
  }

  void _onNewUser(User user) {
    if (user.uuid != '0' && user.uuid != '-1') {
      emit(
        state.copyWith(
          searchHistory: user.searchHistory ?? [],
        ),
      );
    }
  }

  Future<void> _onNewBusStops(List<BusStop>? busStops) async {
    final busStopsSuggestions = await SuggestionsHelperIsolate(
      busStops,
    ).asyncSorting();

    final destinationSuggestions = await DestinationSuggestionsHelperIsolate(
      busStops,
    ).asyncSorting();

    emit(
      state.copyWith(
        busStops: busStops,
        suggestions: busStopsSuggestions,
        destinationsSuggestions: destinationSuggestions,
      ),
    );
  }

  void _resetMainPage(VoidCallback onReset) {
    onReset();

    emit(
      state.copyWith(
        clearTripDate: true,
        // ignore: avoid_redundant_argument_values
        tripDate: null,
        departurePlace: '',
        arrivalPlace: '',
        route: const CustomRoute(null, null),
      ),
    );
  }
}
