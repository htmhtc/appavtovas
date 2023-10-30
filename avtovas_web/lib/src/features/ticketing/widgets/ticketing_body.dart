import 'package:avtovas_web/src/common/constants/web_assets.dart';
import 'package:avtovas_web/src/common/constants/web_dimensions.dart';
import 'package:avtovas_web/src/common/constants/web_fonts.dart';
import 'package:avtovas_web/src/features/ticketing/cubit/ticketing_cubit.dart';
import 'package:avtovas_web/src/features/ticketing/widgets/passenger_selector_sheet.dart';
import 'package:avtovas_web/src/features/ticketing/widgets/ticketing_shimmer_content.dart';
import 'package:collection/collection.dart';
import 'package:common/avtovas_common.dart';
import 'package:common/avtovas_utils_widgets.dart';
import 'package:core/avtovas_core.dart';
import 'package:core/domain/entities/occupied_seat/occupied_seat.dart';
import 'package:core/domain/entities/one_c_entities/seats_scheme.dart';
import 'package:core/domain/entities/single_trip/single_trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class TicketingBody extends StatefulWidget {
  final SingleTrip trip;
  final TicketingCubit cubit;
  final bool smartLayout;

  const TicketingBody({
    required this.trip,
    required this.cubit,
    required this.smartLayout,
    super.key,
  });

  @override
  State<TicketingBody> createState() => _TicketingBodyState();
}

class _TicketingBodyState extends State<TicketingBody> {
  late final TextEditingController _emailController;
  late List<List<GlobalKey<FormState>>> _validateKeys;
  late final GlobalKey<FormState> _emailSenderValidateKey;

  @override
  void initState() {
    super.initState();

    widget.cubit.setSingleTrip(widget.trip);

    _emailController = TextEditingController();
    _emailSenderValidateKey = GlobalKey<FormState>();
    _validateKeys = [];
    _fillValidateKeys(passengerIndex: 0);
  }

  void _fillValidateKeys({required int passengerIndex}) {
    setState(
      () => _validateKeys
        ..insert(passengerIndex, [
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
          GlobalKey<FormState>(),
        ]),
    );
  }

  Future<void> _showErrorAlert({
    required BuildContext context,
    required TicketingState state,
    required VoidCallback onClose,
  }) async {
    await SupportMethods.showAvtovasDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AvtovasAlertDialog(
            title: context.locale.errorCode,
            withCancel: false,
            shouldCloseOnOkTap: false,
            widget: Text(state.errorMessage),
            okayCallback: onClose,
          ),
        );
      },
    );
  }

  void _removeValidateKeys({required int passengerIndex}) {
    setState(() => _validateKeys.removeAt(passengerIndex));
  }

  bool _isValid({
    required ValueSetter<int> onGenderStatusChanged,
    required List<Passenger> passengers,
    required List<bool> genderErrors,
  }) {
    final expandedValidateKeys = _validateKeys.expand((keys) => keys);

    final validateValues = <bool>[];

    for (final key in expandedValidateKeys) {
      validateValues.add(key.currentState!.validate());
    }

    for (var i = 0; i < passengers.length; i++) {
      if (passengers[i].gender.isEmpty) onGenderStatusChanged(i);
    }

    final isEmailNotEmpty = _emailSenderValidateKey.currentState!.validate();

    return !validateValues.contains(false) &&
        !genderErrors.contains(true) &&
        isEmailNotEmpty;
  }

  Future<void> _showLoadingIndicator(BuildContext context) async {
    SupportMethods.showAvtovasDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const CupertinoActivityIndicator(
            color: Color(0xFF000000),
          ),
        );
      },
    );
  }

  bool _loadingListenWhen(TicketingState prev, TicketingState current) {
    return prev.isLoading != current.isLoading;
  }

  void _loadingListener(BuildContext context, TicketingState state) {
    if (state.isLoading) {
      _showLoadingIndicator(context);
    }

    if (state.isErrorRead) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  bool _alertListenWhen(TicketingState prev, TicketingState current) {
    return !prev.shouldShowErrorAlert && current.shouldShowErrorAlert;
  }

  void _alertListener(BuildContext context, TicketingState state) {
    if (state.shouldShowErrorAlert) {
      _showErrorAlert(
        context: context,
        state: state,
        onClose: widget.cubit.closeErrorAlert,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    for (final keysList in _validateKeys) {
      keysList.clear();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketingCubit, TicketingState>(
      bloc: widget.cubit,
      listener: _alertListener,
      listenWhen: _alertListenWhen,
      builder: (context, state) {
        if (state.saleSession == null || state.occupiedSeat == null) {
          return const TicketingShimmerContent();
        }

        final departureDate =
            state.saleSession!.trip.departureTime.formatDay(context);
        final departureTime =
            state.saleSession!.trip.departureTime.formatTime();
        final finalPrice = widget.cubit.finalPriceByRate(
          state.passengers.map((pass) => pass.rate).toList(),
          state.saleSession!.trip.fares,
        );

        final bottomContainer = [
          EmailSender(
            controller: _emailController,
            formKey: _emailSenderValidateKey,
            onChanged: widget.cubit.changeUsedEmail,
            backgroundColor: widget.smartLayout
                ? null
                : context.theme.containerBackgroundColor,
            onSavedEmailChanged: (value) {
              widget.cubit.changeSavedEmailUsability(useSavedEmail: value);
              if (value) {
                _emailSenderValidateKey.currentState!.reset();
                _emailController.text = state.availableEmails!.last;
                widget.cubit.changeUsedEmail(state.availableEmails!.last);
              } else {
                _emailController.text = '';
                widget.cubit.changeUsedEmail('');
              }
            },
            savedEmail: state.availableEmails?.first,
            isSavedEmailUsed: state.useSavedEmail,
          ),
          if (!widget.smartLayout) const SizedBox(height: AppDimensions.medium),
          AvtovasButton.text(
            padding: const EdgeInsets.all(AppDimensions.large),
            buttonText: context.locale.buyFor(
              context.locale.price(finalPrice),
            ),
            textStyle: context.themeData.textTheme.titleLarge?.copyWith(
              color: context.theme.whiteTextColor,
              fontSize: WebFonts.sizeHeadlineMedium,
            ),
            onTap: () {
              if (_isValid(
                onGenderStatusChanged: (index) =>
                    widget.cubit.changeGenderErrorStatus(
                  index: index,
                  status: true,
                ),
                passengers: state.passengers,
                genderErrors: state.genderErrors,
              )) {
                widget.cubit.buyTicket();
              }
            },
          ),
        ];

        return BlocListener<TicketingCubit, TicketingState>(
          listener: _loadingListener,
          listenWhen: _loadingListenWhen,
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.large),
            child: Column(
              children: [
                TicketingHeader(
                  departurePlace: state.saleSession!.departure.name,
                  arrivalPlace: state.saleSession!.destination.name,
                  tripDateTime: '$departureDate ${context.locale.inside} '
                      '$departureTime',
                  tripPrice: context.locale.price(finalPrice),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          for (var index = 0;
                              index < state.passengers.length;
                              index++)
                            _PassengerCollapsedContainer(
                              cubit: widget.cubit,
                              validateKeys:
                                  _validateKeys.elementAtOrNull(index),
                              onRemoveTap: () {
                                _removeValidateKeys(passengerIndex: index);
                                widget.cubit
                                    .removePassenger(passengerIndex: index);
                              },
                              passengerIndex: index,
                              ticketPrice: widget.cubit.priceByRate(
                                state.passengers[index].rate,
                                state.saleSession!.trip.fares,
                              ),
                              seatsScheme:
                                  state.saleSession!.trip.bus.seatsScheme,
                              occupiedSeat: state.occupiedSeat,
                            ),
                          AvtovasButton.icon(
                            padding: const EdgeInsets.all(
                              AppDimensions.mediumLarge,
                            ),
                            borderColor: context.theme.mainAppColor,
                            buttonColor: context.theme.transparent,
                            buttonText: context.locale.addPassenger,
                            textStyle: context.themeData.textTheme.titleLarge
                                ?.copyWith(
                              color: context.theme.primaryTextColor,
                            ),
                            backgroundOpacity: 0,
                            mainAxisAlignment: MainAxisAlignment.center,
                            svgPath: WebAssets.roadIcon,
                            onTap: () {
                              _fillValidateKeys(
                                passengerIndex: state.passengers.length - 1,
                              );
                              widget.cubit.addNewPassenger();
                            },
                          ),
                          if (widget.smartLayout)
                            Column(children: bottomContainer),
                        ].insertBetween(
                          const SizedBox(height: AppDimensions.large),
                        ),
                      ),
                    ),
                    if (!widget.smartLayout)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.extraLarge,
                          ),
                          child: Column(children: bottomContainer),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final class _PassengerCollapsedContainer extends StatefulWidget {
  final TicketingCubit cubit;
  final VoidCallback onRemoveTap;
  final int passengerIndex;
  final String ticketPrice;
  final List<GlobalKey<FormState>>? validateKeys;
  final List<SeatsScheme>? seatsScheme;
  final List<OccupiedSeat>? occupiedSeat;

  const _PassengerCollapsedContainer({
    required this.cubit,
    required this.onRemoveTap,
    required this.passengerIndex,
    required this.ticketPrice,
    required this.validateKeys,
    required this.seatsScheme,
    required this.occupiedSeat,
  });

  @override
  State<_PassengerCollapsedContainer> createState() =>
      _PassengerCollapsedContainerState();
}

class _PassengerCollapsedContainerState
    extends State<_PassengerCollapsedContainer> {
  final reservedSeats = []; // List of reserved seats
  final availableSeats = <String>[]; // List of all available seats

  @override
  void initState() {
    super.initState();
    _initializeSeats();
  }

  Future<void> _showSelector(
    BuildContext context,
    List<Passenger>? passengers,
  ) async {
    await SupportMethods.showAvtovasBottomSheet(
      sheetTitle: 'Пассажиры',
      context: context,
      child: PassengerSelectorSheet(
        existentPassengers: passengers,
        onPassengerChanged: (passenger) => widget.cubit.changeIndexedPassenger(
          passengerIndex: widget.passengerIndex,
          existentPassenger: passenger,
        ),
      ),
    );

    for (final key in widget.validateKeys ?? <GlobalKey<FormState>>[]) {
      key.currentState?.reset();
    }
  }

  void _initializeSeats() {
    reservedSeats.addAll(
      widget.occupiedSeat?.map((seat) => seat.number) ?? [],
    );

    final filteredSeats =
        widget.seatsScheme?.where((seat) => seat.seatNum != '0').toList() ?? [];

    availableSeats
      ..addAll(filteredSeats.map((seat) => seat.seatNum))
      ..removeWhere(reservedSeats.contains);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketingCubit, TicketingState>(
      bloc: widget.cubit,
      builder: (context, state) {
        final passenger = state.passengers[widget.passengerIndex];

        return PassengerCollapsedContainer(
          formKeys: widget.validateKeys,
          isGenderError: state.genderErrors[widget.passengerIndex],
          onGenderChanged: () => widget.cubit.changeGenderErrorStatus(
            index: widget.passengerIndex,
            status: false,
          ),
          availableSeats: availableSeats,
          onSeatChanged: (value) => widget.cubit.changePassengerSeatNumber(
            passengerIndex: widget.passengerIndex,
            seat: value,
          ),
          passengerNumber: widget.passengerIndex + 1,
          withRemoveButton: widget.passengerIndex != 0,
          removePassenger: widget.onRemoveTap,
          ticketPrice: context.locale.price(widget.ticketPrice),
          onSurnameVisibleChanged: (value) =>
              widget.cubit.changeSurnameVisibility(
            passengerIndex: widget.passengerIndex,
            withoutSurname: value,
          ),
          noSurname: state.surnameStatuses[widget.passengerIndex],
          onPassengerChanged: ({
            String? firstName,
            String? lastName,
            String? surname,
            String? gender,
            DateTime? birthdayDate,
            String? citizenship,
            String? documentType,
            String? documentData,
            String? rate,
          }) {
            widget.cubit.changeIndexedPassenger(
              passengerIndex: widget.passengerIndex,
              firstName: firstName,
              lastName: lastName,
              surname: surname,
              gender: gender,
              birthdayDate: birthdayDate,
              citizenship: citizenship,
              documentType: documentType,
              documentData: documentData,
              rate: rate,
            );
          },
          firstNameValue: passenger.firstName,
          lastNameValue: passenger.lastName,
          surnameValue: passenger.surname,
          genderValue: passenger.gender,
          birthdayDateValue: passenger.birthdayDate,
          citizenshipValue: passenger.citizenship,
          documentTypeValue: passenger.documentType,
          documentDataValue: passenger.documentData,
          rateValue: passenger.rate,
          seatValue: state.seats[widget.passengerIndex],
          onSelectPassengerTap: () {
            _showSelector(
              context,
              state.existentPassengers,
            );
            widget.cubit.changeGenderErrorStatus(
              index: widget.passengerIndex,
              status: false,
            );
          },
        );
      },
    );
  }
}