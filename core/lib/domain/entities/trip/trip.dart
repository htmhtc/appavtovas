import 'package:core/domain/entities/trip/bus.dart';
import 'package:core/domain/entities/trip/carrier_data.dart';
import 'package:core/domain/entities/trip/departure.dart';
import 'package:core/domain/entities/trip/destination.dart';
import 'package:equatable/equatable.dart';

final class TripModel extends Equatable {
  final String? id;
  final String? routeId;
  final String? scheduleTripId;
  final String? routeName;
  final String? routeNum;
  final String? carrier;
  final Bus? bus;
  final String? driver1;
  final String? driver2;
  final String? frequency;
  final String? waybillNum;
  final String? status;
  final String? statusPrint;
  final String? statusReason;
  final String? statusDate;
  final Departure? departure;
  final String? departureTime;
  final String? arrivalToDepartureTime;
  final Destination? destination;
  final String? arrivalTime;
  final String? distance;
  final String? duration;
  final String? transitSeats;
  final String? freeSeatsAmount;
  final String? passengerFareCost;
  final String? platform;
  final String? onSale;
  final String? additional;
  final String? currency;
  final CarrierData? carrierData;
  final String? checkMan;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        routeId,
        scheduleTripId,
        routeName,
        routeNum,
        carrier,
        bus,
        driver1,
        driver2,
        frequency,
        waybillNum,
        status,
        statusPrint,
        statusReason,
        statusDate,
        departure,
        departureTime,
        arrivalToDepartureTime,
        destination,
        arrivalTime,
        distance,
        duration,
        transitSeats,
        freeSeatsAmount,
        passengerFareCost,
        platform,
        onSale,
        additional,
        currency,
        carrierData,
        checkMan,
      ];

  const TripModel({
    this.id,
    this.routeId,
    this.scheduleTripId,
    this.routeName,
    this.routeNum,
    this.carrier,
    this.bus,
    this.driver1,
    this.driver2,
    this.frequency,
    this.waybillNum,
    this.status,
    this.statusPrint,
    this.statusReason,
    this.statusDate,
    this.departure,
    this.departureTime,
    this.arrivalToDepartureTime,
    this.destination,
    this.arrivalTime,
    this.distance,
    this.duration,
    this.transitSeats,
    this.freeSeatsAmount,
    this.passengerFareCost,
    this.platform,
    this.onSale,
    this.additional,
    this.currency,
    this.carrierData,
    this.checkMan,
  });
}
