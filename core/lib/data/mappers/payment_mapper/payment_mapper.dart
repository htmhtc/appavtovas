import 'package:core/avtovas_mapper.dart';
import 'package:core/data/mappers/base_mapper.dart';
import 'package:core/domain/entities/one_c_payment/one_c_payment.dart';

final class OneCPaymentMapper implements BaseMapper<OneCPayment> {
  @override
  Map<String, dynamic> toJson(OneCPayment data) {
    return {
      _Fields.number: data.number,
      _Fields.trip: TripMapper().toJson(data.trip),
      _Fields.departure: DepartureMapper().toJson(data.departure),
      _Fields.departureTime: data.departureTime,
      _Fields.destination: DestinationMapper().toJson(data.destination),
      _Fields.ticket:
          data.ticket.map((ticket) => TicketMapper().toJson(ticket)).toList(),
      _Fields.occupiedSeats: data.occupiedSeats
          .map((seat) => OccupiedSeatMapper().toJson(seat))
          .toList(),
      _Fields.amount: data.amount,
      _Fields.services: data.services,
      _Fields.currency: data.currency,
    };
  }

  @override
  OneCPayment fromJson(Map<String, dynamic> json) {
    final jsonOccupiedSeats = json[_Fields.occupiedSeats];
    final jsonTicket = json[_Fields.ticket];
    return OneCPayment(
      number: json[_Fields.number] ?? '',
      trip: TripMapper().fromJson(json[_Fields.trip]),
      departure: DepartureMapper().fromJson(json[_Fields.departure]),
      departureTime: json[_Fields.departureTime] ?? '',
      destination: DestinationMapper().fromJson(json[_Fields.destination]),
      ticket: jsonTicket is List<dynamic>
          ? jsonTicket.map((e) => TicketMapper().fromJson(e)).toList()
          : [
              TicketMapper().fromJson(jsonTicket),
            ],
      occupiedSeats: jsonOccupiedSeats is List<dynamic>
          ? jsonOccupiedSeats
              .map((e) => OccupiedSeatMapper().fromJson(e))
              .toList()
          : [OccupiedSeatMapper().fromJson(jsonOccupiedSeats)],
      amount: json[_Fields.amount] ?? '',
      services: json[_Fields.services] ?? '',
      currency: json[_Fields.currency] ?? '',
    );
  }
}

abstract final class _Fields {
  static const number = 'Number';
  static const trip = 'Trip';
  static const departure = 'Departure';
  static const departureTime = 'DepartureTime';
  static const destination = 'Destination';
  static const ticket = 'Ticket';
  static const occupiedSeats = 'OccupiedSeats';
  static const amount = 'Amount';
  static const services = 'Services';
  static const currency = 'Currency';
}
