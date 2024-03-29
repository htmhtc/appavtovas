import 'package:core/domain/entities/domain_object.dart';
import 'package:core/domain/entities/one_c_entities/departure.dart';
import 'package:core/domain/entities/one_c_entities/destination.dart';
import 'package:core/domain/entities/single_trip/single_trip.dart';

class StartSaleSession extends DomainObject {
  final String number;
  final SingleTrip trip;
  final Departure departure;
  final String departureTime;
  final Destination destination;
  final String amount;
  final String services;
  final String currency;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        number,
        trip,
        departure,
        departureTime,
        destination,
        amount,
        services,
        currency,
      ];

  const StartSaleSession({
    required this.number,
    required this.trip,
    required this.departure,
    required this.departureTime,
    required this.destination,
    required this.amount,
    required this.services,
    required this.currency,
  });

  factory StartSaleSession.error([String? errorDescription]) =>
      StartSaleSession(
        number: errorDescription ?? '',
        trip: SingleTrip.error(),
        departure: Departure.error(),
        departureTime: '',
        destination: Destination.error(),
        amount: 'error',
        services: '',
        currency: '',
      );

  @override
  StartSaleSession copyWith() {
    return StartSaleSession(
      number: number,
      trip: trip,
      departure: departure,
      departureTime: departureTime,
      destination: destination,
      amount: amount,
      services: services,
      currency: currency,
    );
  }
}
