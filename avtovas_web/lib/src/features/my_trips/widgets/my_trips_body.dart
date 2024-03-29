import 'package:avtovas_web/src/common/constants/app_animations.dart';
import 'package:avtovas_web/src/common/constants/app_dimensions.dart';
import 'package:avtovas_web/src/common/utils/mocks.dart';
import 'package:avtovas_web/src/common/utils/scroll_behavior.dart';
import 'package:avtovas_web/src/features/my_trips/cubit/my_trips_cubit.dart';
import 'package:avtovas_web/src/features/my_trips/widgets/my_trip_tab/archive_trips/archive_trips.dart';
import 'package:avtovas_web/src/features/my_trips/widgets/my_trip_tab/completed_trips/completed_trips.dart';
import 'package:avtovas_web/src/features/my_trips/widgets/my_trip_tab/refund_trips/refund_trips.dart';
import 'package:avtovas_web/src/features/my_trips/widgets/my_trip_tab/upcoming_trips/upcoming_trips.dart';
import 'package:avtovas_web/src/features/my_trips/widgets/trips_status_selector_button.dart';
import 'package:common/avtovas_common.dart';
import 'package:common/avtovas_utils_widgets.dart';
import 'package:core/domain/utils/user_trip_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

final class MyTripsBody extends StatefulWidget {
  final MyTripsCubit cubit;
  final bool smartLayout;
  final String paymentId;
  final String statusedTripId;

  const MyTripsBody({
    required this.cubit,
    required this.smartLayout,
    required this.paymentId,
    required this.statusedTripId,
    super.key,
  });

  @override
  State<MyTripsBody> createState() => _MyTripsBodyState();
}

class _MyTripsBodyState extends State<MyTripsBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    if (widget.paymentId.isNotEmpty && widget.statusedTripId.isNotEmpty) {
      widget.cubit.paymentProcessPassed(
        paymentId: widget.paymentId,
        statusedTripId: widget.statusedTripId,
        onErrorAction: () => _showPaymentErrorDialog(context),
      );
    }
  }

  String _selectorTextFromStatus(UserTripStatus status, BuildContext context) {
    return switch (status) {
      UserTripStatus.upcoming => context.locale.upcoming,
      UserTripStatus.finished => context.locale.completed,
      UserTripStatus.archive => context.locale.archived,
      UserTripStatus.declined => context.locale.refund,
      UserTripStatus.unimplemented => '',
    };
  }

  Future<void> _showPaymentErrorDialog(BuildContext context) {
    return SupportMethods.showAvtovasDialog(
      context: context,
      builder: (context) {
        return const AvtovasAlertDialog(
          title:
              'Ошибка во время платежа.\nПо техническим причинам билет не может быть продан. Деньги скоро поступят на ваше платёжное средство в полном объёме, приносим извинения за доставленные неудобства.\n\nВ случае необходимости, Вы можете связаться с технической поддержкой в разделе "Позвонить или задать вопрос" во вкладке "Помощь" по телефону горячей линии, либо отправив письмо на электронную почту.',
          withCancel: false,
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTripsCubit, MyTripsState>(
      bloc: widget.cubit,
      builder: (context, state) {
        return state.shouldShowLoadingAnimation
            ? const _LoadingPageBody()
            : Column(
                children: [
                  const SizedBox(height: AppDimensions.large),
                  ScrollConfiguration(
                    behavior: WebScrollBehavior(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.medium,
                      ),
                      child: RawScrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        thumbColor: context.theme.mainAppColor,
                        thickness: 2,
                        crossAxisMargin: -10,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (final status in UserTripStatus.values)
                                if (status != UserTripStatus.unimplemented)
                                  TripStatusSelectorButton(
                                    onTripsStatusChanged:
                                        widget.cubit.updateCurrentTripsStatus,
                                    selectorStatus: status,
                                    selectedStatus: state.currentTripsStatus,
                                    text: _selectorTextFromStatus(
                                      status,
                                      context,
                                    ),
                                  ),
                            ].insertBetween(
                              const SizedBox(width: AppDimensions.large),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.extraLarge),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.large,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: KeyedSubtree(
                        key: ValueKey<UserTripStatus>(state.currentTripsStatus),
                        child: Builder(
                          builder: (context) {
                            return switch (state.currentTripsStatus) {
                              UserTripStatus.upcoming => UpcomingTrips(
                                  smartLayout: widget.smartLayout,
                                  cubit: widget.cubit,
                                ),
                              UserTripStatus.finished => CompletedTrips(
                                  smartLayout: widget.smartLayout,
                                  trips: state.finishedStatusedTrips,
                                  mockBooking: Mocks.booking,
                                ),
                              UserTripStatus.archive => ArchiveTrips(
                                  smartLayout: widget.smartLayout,
                                  trips: state.archiveStatusedTrips,
                                  onRemoveButtonTap:
                                      widget.cubit.removeFromArchive,
                                ),
                              UserTripStatus.declined => RefundTrips(
                                  smartLayout: widget.smartLayout,
                                  trips: state.declinedStatusedTrips,
                                  onRemoveButtonTap: (uid) =>
                                      widget.cubit.updateTripStatus(
                                    uid,
                                    UserTripStatus.archive,
                                    UserTripCostStatus.expiredReverse,
                                  ),
                                ),
                              UserTripStatus.unimplemented => const SizedBox(),
                            };
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}

final class _LoadingPageBody extends StatelessWidget {
  const _LoadingPageBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
        Lottie.asset(
          AppLottie.busLoading,
          width: AppDimensions.extraLarge * 3,
          height: AppDimensions.extraLarge * 3,
          repeat: true,
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
      ],
    );
  }
}
