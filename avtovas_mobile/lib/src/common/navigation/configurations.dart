import 'package:avtovas_mobile/src/common/navigation/routes.dart';
import 'package:avtovas_mobile/src/features/authorization/pages/authorization_page.dart';
import 'package:avtovas_mobile/src/features/ticketing/pages/ticketing_page.dart';
import 'package:avtovas_mobile/src/features/trip_details/pages/trip_details_page.dart';
import 'package:avtovas_mobile/src/features/trips_schedule_page/pages/trips_schedule_page.dart';
import 'package:common/avtovas_common.dart';
import 'package:common/avtovas_navigation.dart';

PageConfiguration mainConfig() {
  return PageConfiguration(path: Routes.mainPath.name);
}

PageConfiguration tripsScheduleConfig({
  required String departurePlace,
  required String arrivalPlace,
  required DateTime tripDate,
}) {
  return PageConfiguration(
    path: Routes.searchTripsPath.name,
    args: TripsScheduleArguments(
      departurePlace: departurePlace,
      arrivalPlace: arrivalPlace,
      tripDate: tripDate,
    ),
  );
}

PageConfiguration tripDetailsConfig({
  required String routeId,
  required String busStop,
}) {
  return PageConfiguration(
    path: Routes.tripDetailsPath.name,
    args: TripDetailsArguments(
      routeId: routeId,
      busStop: busStop,
    ),
  );
}

PageConfiguration ticketingConfig({
  required String tripId,
  required String departure,
  required String destination,
}) {
  return PageConfiguration(
    path: Routes.ticketingPath.name,
    args: TicketingArguments(
      tripId: tripId,
      departure: departure,
      destination: destination,
    ),
  );
}

PageConfiguration passengersConfig() {
  return PageConfiguration(path: Routes.passengersPath.name);
}

PageConfiguration paymentsHistoryConfig() {
  return PageConfiguration(path: Routes.paymentsHistoryPath.name);
}

PageConfiguration notificationsConfig() {
  return PageConfiguration(path: Routes.notificationsPath.name);
}

// Other profile configs

PageConfiguration contactsConfig() {
  return PageConfiguration(path: Routes.contactsPath.name);
}

PageConfiguration authConfig({
  required AuthorizationContent content,
  String? phoneNumber,
}) {
  return PageConfiguration(
    path: Routes.authPath.name,
    args: AuthorizationPageArguments(
      content: content,
      phoneNumber: phoneNumber,
    ),
  );
}
