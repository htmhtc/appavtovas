// ignore_for_file: member-ordering

part of 'trips_schedule_cubit.dart';

class TripsScheduleState extends Equatable {
  final CustomRoute route;
  final List<BusStop>? busStops;
  final List<Trip>? foundedTrips;
  final List<String>? suggestions;
  final List<String>? destinationsSuggestions;
  final SortOptions selectedOption;
  final String departurePlace;
  final String arrivalPlace;
  final DateTime? tripDate;

  const TripsScheduleState({
    required this.route,
    required this.busStops,
    required this.suggestions,
    required this.destinationsSuggestions,
    required this.selectedOption,
    required this.departurePlace,
    required this.arrivalPlace,
    this.tripDate,
    this.foundedTrips,
  });

  TripsScheduleState copyWith({
    CustomRoute? route,
    List<BusStop>? busStops,
    List<Trip>? foundedTrips,
    List<String>? suggestions,
    List<String>? destinationsSuggestions,
    SortOptions? selectedOption,
    String? departurePlace,
    String? arrivalPlace,
    DateTime? tripDate,
    bool? clearFoundedTrips,
  }) {
    return TripsScheduleState(
      route: route ?? this.route,
      busStops: busStops ?? this.busStops,
      foundedTrips: clearFoundedTrips != null
          ? clearFoundedTrips
              ? foundedTrips
              : foundedTrips ?? this.foundedTrips
          : foundedTrips ?? this.foundedTrips,
      suggestions: suggestions ?? this.suggestions,
      destinationsSuggestions:
          destinationsSuggestions ?? this.destinationsSuggestions,
      selectedOption: selectedOption ?? this.selectedOption,
      departurePlace: departurePlace ?? this.departurePlace,
      arrivalPlace: arrivalPlace ?? this.arrivalPlace,
      tripDate: tripDate ?? this.tripDate,
    );
  }

  @override
  List<Object?> get props => [
        route,
        busStops,
        foundedTrips,
        suggestions,
        destinationsSuggestions,
        selectedOption,
        departurePlace,
        arrivalPlace,
        tripDate,
      ];
}
