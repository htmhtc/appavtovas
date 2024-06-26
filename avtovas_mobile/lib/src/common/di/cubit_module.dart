import 'package:avtovas_mobile/src/common/di/injector.dart';
import 'package:avtovas_mobile/src/common/shared_cubit/app_overlay/app_overlay_cubit.dart';
import 'package:avtovas_mobile/src/common/shared_cubit/navigation_panel/app_configuration_cubit.dart';
import 'package:avtovas_mobile/src/common/shared_cubit/theme/theme_shared_cubit.dart';
import 'package:avtovas_mobile/src/features/about/cubit/about_cubit.dart';
import 'package:avtovas_mobile/src/features/app/cubit/app_cubit.dart';
import 'package:avtovas_mobile/src/features/authorization/cubit/authorization_cubit.dart';
import 'package:avtovas_mobile/src/features/avtovas_contacts/cubit/avtovas_contacts_cubit.dart';
import 'package:avtovas_mobile/src/features/bus_station_contacts/cubit/bus_station_contacts_cubit.dart';
import 'package:avtovas_mobile/src/features/main/cubit/my_trips_cubit/my_trips_cubit.dart';
import 'package:avtovas_mobile/src/features/main/cubit/profile_cubit/profile_cubit.dart';
import 'package:avtovas_mobile/src/features/main/cubit/search_cubit/main_search_cubit.dart';
import 'package:avtovas_mobile/src/features/notifications/cubit/notifications_cubit.dart';
import 'package:avtovas_mobile/src/features/passengers/cubit/passengers_cubit.dart';
import 'package:avtovas_mobile/src/features/payments-history/cubit/payments_history_cubit.dart';
import 'package:avtovas_mobile/src/features/reference_info/cubit/refernce_info_cubit.dart';
import 'package:avtovas_mobile/src/features/return_condition/cubit/return_condition_cubit.dart';
import 'package:avtovas_mobile/src/features/support/cubit/support_cubit.dart';
import 'package:avtovas_mobile/src/features/terms/cubit/terms_cubit.dart';
import 'package:avtovas_mobile/src/features/ticketing/cubit/ticketing_cubit.dart';
import 'package:avtovas_mobile/src/features/trip_details/cubit/trip_details_cubit.dart';
import 'package:avtovas_mobile/src/features/trips_schedule_page/cubit/trips_schedule_cubit.dart';

void initSharedCubits() {
  i
    ..registerLazySingleton<ThemeSharedCubit>(
      ThemeSharedCubit.new,
    )
    ..registerSingleton<AppConfigurationCubit>(
      AppConfigurationCubit(
        i.get(),
        i.get(),
        i.get(),
        i.get(),
        i.get(),
      ),
    )
    ..registerLazySingleton<AppOverlayCubit>(
      AppOverlayCubit.new,
    );
}

void initCubits() {
  i
    ..registerFactory<AppCubit>(
      () => AppCubit(
        i.get(),
        i.get(),
      ),
    )
    ..registerFactory<TripsScheduleCubit>(
      () => TripsScheduleCubit(
        i.get(),
      ),
    )
    ..registerFactory<MainSearchCubit>(
      () => MainSearchCubit(
        i.get(),
      ),
    )
    ..registerFactory<TripDetailsCubit>(
      () => TripDetailsCubit(
        i.get(),
      ),
    )
    ..registerFactory<NotificationsCubit>(
      () => NotificationsCubit(
        i.get(),
      ),
    )
    ..registerFactory<PassengersCubit>(
      () => PassengersCubit(
        i.get(),
      ),
    )
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(
        i.get(),
      ),
    )
    ..registerFactory<TicketingCubit>(
      () => TicketingCubit(
        i.get(),
      ),
    )
    ..registerFactory<PaymentsHistoryCubit>(
      () => PaymentsHistoryCubit(
        i.get(),
      ),
    )
    ..registerFactory<RefereceInfoCubit>(
      RefereceInfoCubit.new,
    )
    ..registerFactory<TermsCubit>(
      TermsCubit.new,
    )
    ..registerFactory<AboutCubit>(
      AboutCubit.new,
    )
    ..registerFactory<SupportCubit>(
      SupportCubit.new,
    )
    ..registerFactory<AvtovasContactsCubit>(
      () => AvtovasContactsCubit(
        i.get(),
      ),
    )
    ..registerFactory<BusStationContactsCubit>(
      () => BusStationContactsCubit(
        i.get(),
      ),
    )
    ..registerFactory<AuthorizationCubit>(
      () => AuthorizationCubit(
        i.get(),
      ),
    )
    ..registerFactory<ReturnConditionCubit>(
      ReturnConditionCubit.new,
    )
    ..registerFactory<MyTripsCubit>(
      () => MyTripsCubit(
        i.get(),
      ),
    );
}
