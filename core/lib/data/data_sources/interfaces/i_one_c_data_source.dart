import 'package:core/avtovas_core.dart';
import 'package:core/domain/entities/add_ticket/add_ticket.dart';
import 'package:core/domain/entities/bus_stop/bus_stop.dart';
import 'package:core/domain/entities/occupied_seat/occupied_seat.dart';
import 'package:core/domain/entities/oneC_entities/personal_data.dart';
import 'package:core/domain/entities/reserve_order/reserve_order.dart';
import 'package:core/domain/entities/set_ticket_data/set_ticket_data.dart';
import 'package:core/domain/entities/single_trip/single_trip.dart';
import 'package:core/domain/entities/start_sale_session/start_sale_session.dart';
import 'package:core/domain/entities/trip/trip.dart';

abstract interface class IOneCDataSource {
  Stream<List<BusStop>?> get busStopsStream;

  Stream<List<Trip>?> get tripsStream;

  Stream<SingleTrip?> get singleTripStream;

  Stream<StartSaleSession?> get saleSessionStream;

  Stream<List<OccupiedSeat>?> get occupiedSeat;

  Stream<AddTicket?> get addTicketsStream;

  Stream<SetTicketData?> get setTicketDataStream;

  Stream<ReserveOrder?> get reserveOrderStream;

  Future<void> getBusStops();

  Future<void> getTrips({
    required String departure,
    required String destination,
    required String tripsDate,
  });

  Future<void> getTrip({
    required String tripId,
    required String busStop,
  });

  Future<void> startSaleSession({
    required String tripId,
    required String departure,
    required String destination,
  });

  Future<void> getOccupiedSeat({
    required String tripId,
    required String departure,
    required String destination,
  });

  Future<void> addTickets({
    required List<Passenger> passengerList,
    required List<String> seats,
    required String orderId,
    String? parentTicketSeatNum,
  });

  Future<void> setTicketData({
    required String orderId,
    required List<PersonalData> personalData,
  });

  Future<void> reserveOrder({
    required String orderId,
    String? name,
    String? phone,
    String? email,
    String? comment,
  });

  void clearBusStop();

  void clearTrips();

  void clearTrip();

  void clearSession();

  void clearOccupiedSeat();

  void clearAddTickets();

  void clearSetTicketData();

  void clearReserveOrder();
}
