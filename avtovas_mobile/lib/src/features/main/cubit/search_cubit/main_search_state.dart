part of 'main_search_cubit.dart';

final class MainSearchState extends Equatable {
  final DateTime? tripDate;
  final String? departurePlace;
  final String? arrivalPlace;
  final CustomRoute route;
  final List<BusStop> avtovasBusStops;
  final List<BusStop> stepanovBusStops;
  final List<String> suggestions;

  @override
  List<Object?> get props => [
        tripDate,
        departurePlace,
        arrivalPlace,
        route,
        avtovasBusStops,
        stepanovBusStops,
        suggestions,
      ];

  const MainSearchState({
    required this.route,
    required this.avtovasBusStops,
    required this.stepanovBusStops,
    required this.suggestions,
    this.departurePlace,
    this.arrivalPlace,
    this.tripDate,
  });

  MainSearchState copyWith({
    DateTime? tripDate,
    String? departurePlace,
    String? arrivalPlace,
    CustomRoute? route,
    List<BusStop>? avtovasBusStops,
    List<BusStop>? stepanovBusStops,
    List<String>? suggestions,
    bool? clearTripDate,
  }) {
    return MainSearchState(
      tripDate: clearTripDate != null
          ? clearTripDate
              ? tripDate
              : tripDate ?? this.tripDate
          : tripDate ?? this.tripDate,
      departurePlace: departurePlace ?? this.departurePlace,
      arrivalPlace: arrivalPlace ?? this.arrivalPlace,
      route: route ?? this.route,
      avtovasBusStops: avtovasBusStops ?? this.avtovasBusStops,
      stepanovBusStops: stepanovBusStops ?? this.stepanovBusStops,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}