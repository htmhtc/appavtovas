import 'package:avtovas_mobile/src/common/constants/app_assets.dart';
import 'package:avtovas_mobile/src/common/constants/app_dimensions.dart';
import 'package:avtovas_mobile/src/common/constants/app_fonts.dart';
import 'package:avtovas_mobile/src/common/cubit_scope/cubit_scope.dart';
import 'package:avtovas_mobile/src/common/shared_cubit/navigation_panel/navigation_panel_cubit.dart';
import 'package:avtovas_mobile/src/common/widgets/support_methods/support_methods.dart';
import 'package:avtovas_mobile/src/features/main/cubit/profile_cubit/profile_cubit.dart';
import 'package:avtovas_mobile/src/features/main/utils/alert_types.dart';
import 'package:avtovas_mobile/src/features/main/widgets/profile_widgets/profile_alert.dart';
import 'package:avtovas_mobile/src/features/main/widgets/profile_widgets/profile_button.dart';
import 'package:common/avtovas_common.dart';
import 'package:common/avtovas_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool _listenWhen(ProfileState prev, ProfileState current) {
    return prev.route.type == null && current.route.type != null;
  }

  void _listener(ProfileState state) {
    if (state.route.type != null) {
      context.navigateTo(state.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CubitScope<ProfileCubit>(
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (_, state) => _listener(state),
        listenWhen: _listenWhen,
        builder: (context, state) {
          final cubit = CubitScope.of<ProfileCubit>(context);

          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: state.isAuthorized == null
                    ? const _ShimmerProfileWidgets()
                    : _ProfileWidgets(
                        onExitTap: cubit.onExitTap,
                        onPassengersTap: cubit.onPassengersButtonTap,
                        onPaymentsHistoryTap: cubit.onPaymentsHistoryButtonTap,
                        onNotificationsTap: cubit.onNotificationsButtonTap,
                        onReferenceInfoTap: cubit.onReferenseInfoButtonTap,
                        onTermsTap: cubit.onTermsButtonTap,
                        onAboutTap: cubit.onAboutButtonTap,
                        onPhoneChanged: cubit.onAuthorizationNumberChanged,
                        onSendButtonTap: cubit.onSendButtonTap,
                        onTextTap: cubit.onTextTap,
                        state: state,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

final class _ProfileWidgets extends StatelessWidget {
  final VoidCallback onExitTap;
  final VoidCallback onPassengersTap;
  final VoidCallback onPaymentsHistoryTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onReferenceInfoTap;
  final VoidCallback onTermsTap;
  final VoidCallback onAboutTap;
  final ValueChanged<String> onPhoneChanged;
  final VoidCallback onSendButtonTap;
  final VoidCallback onTextTap;
  final ProfileState state;

  const _ProfileWidgets({
    required this.onExitTap,
    required this.onPassengersTap,
    required this.onPaymentsHistoryTap,
    required this.onNotificationsTap,
    required this.onReferenceInfoTap,
    required this.onTermsTap,
    required this.onAboutTap,
    required this.onPhoneChanged,
    required this.onSendButtonTap,
    required this.onTextTap,
    required this.state,
  });

// TODO(dev): Don't use System Overlays with go_router.
// TODO(dev): We should change all of the same places.
// ignore: unused_element
  Future<void> _showDialog(BuildContext context, VoidCallback onExit) async {
    SupportMethods.showAvtovasDialog(
      context: context,
      showWindow: () => showDialog(
        context: context,
        builder: (context) {
          return AvtovasAlertDialog(
            title: context.locale.exitWarning,
            okayCallback: () {
              Navigator.pop(context);
              onExit();
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.medium),
        ProfileButton(
          onTap: () {
            CubitScope.of<NavigationPanelCubit>(context)
                .updateNavigationIndex(1);
          },
          buttonText: context.locale.myTrips,
          svgPath: AppAssets.tripsIcon,
        ),
        ProfileButton(
          onTap: onPassengersTap,
          buttonText: context.locale.passenger,
          svgPath: AppAssets.passengerIcon,
        ),
        ProfileButton(
          onTap: onPaymentsHistoryTap,
          buttonText: context.locale.paymentHistory,
          svgPath: AppAssets.paymentHistoryIcon,
        ),
        ProfileButton(
          onTap: onNotificationsTap,
          buttonText: context.locale.notifications,
          svgPath: AppAssets.notificationsIcon,
        ),
        ProfileButton(
          onTap: onReferenceInfoTap,
          buttonText: context.locale.referenceInformation,
          svgPath: AppAssets.infoIcon,
        ),
        ProfileButton(
          onTap: onTermsTap,
          buttonText: context.locale.termAndConditions,
          svgPath: AppAssets.listIcon,
        ),
        ProfileButton(
          onTap: onAboutTap,
          buttonText: context.locale.aboutApp,
          svgPath: AppAssets.microBusIcon,
        ),
        if (state.isAuthorized!) ...[
          const Spacer(),
          AvtovasButton.text(
            buttonText: context.locale.exit,
            onTap: onExitTap,
            margin: const EdgeInsets.all(AppDimensions.large),
            padding: const EdgeInsets.all(AppDimensions.mediumLarge),
            buttonColor: context.theme.transparent,
            borderColor: context.theme.mainAppColor,
            backgroundOpacity: 0,
            textStyle: context.themeData.textTheme.titleLarge?.copyWith(
              fontSize: AppFonts.sizeHeadlineMedium,
              color: context.theme.mainAppColor,
            ),
          ),
        ] else ...[
          const SizedBox(height: AppDimensions.large),
          AuthorizationPhoneContainer(
            onNumberChanged: onPhoneChanged,
            onSendButtonTap: onSendButtonTap,
            onTextTap: onTextTap,
            number: state.authorizationNumber ?? '',
          ),
        ],
      ],
    );
  }
}

final class _ShimmerProfileWidgets extends StatelessWidget {
  const _ShimmerProfileWidgets();

  @override
  Widget build(BuildContext context) {
    const buttonsAmount = 7;
    const authorizationHeight = 400.0;

    return Column(
      children: [
        for (var i = 0; i < buttonsAmount; i++) const BaseShimmer(),
        const SizedBox(height: AppDimensions.large),
        const BaseShimmer(shimmerHeight: authorizationHeight),
      ],
    );
  }
}

final class _Alert extends StatelessWidget {
  final ProfileCubit cubit;
  final ProfileAlertTypes alertTypes;

  const _Alert({
    required this.cubit,
    required this.alertTypes,
  });

  @override
  Widget build(BuildContext context) {
    return switch (alertTypes) {
      ProfileAlertTypes.sendCallWithCode => ProfileAlert(
          cubit: cubit,
        ),
    };
  }
}
