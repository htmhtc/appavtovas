import 'package:avtovas_mobile/src/common/di/injector.dart';
import 'package:avtovas_mobile/src/common/shared_cubit/navigation_panel/app_configuration_cubit.dart';
import 'package:avtovas_mobile/src/features/main/widgets/main_search_widgets/main_search_body.dart';
import 'package:avtovas_mobile/src/features/main/widgets/my_trips_widgets/my_trips_body.dart';
import 'package:avtovas_mobile/src/features/main/widgets/profile_widgets/profile_body.dart';
import 'package:avtovas_mobile/src/features/main/widgets/support_widgets/support_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class MainBodySelector extends StatefulWidget {
  final PageController pageController;
  final EdgeInsets viewInsets;

  final ValueChanged<bool> loadingStatusChanged;

  const MainBodySelector({
    required this.pageController,
    required this.viewInsets,
    required this.loadingStatusChanged,
    super.key,
  });

  @override
  State<MainBodySelector> createState() => _MainBodySelectorState();
}

class _MainBodySelectorState extends State<MainBodySelector> {
  final _navigationPanelCubit = i.get<AppConfigurationCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigurationCubit, AppConfigurationState>(
      bloc: _navigationPanelCubit,
      builder: (context, state) {
        return PageView(
          controller: widget.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MainSearchBody(viewInsets: widget.viewInsets),
            MyTripsBody(
              loadingStatusChanged: widget.loadingStatusChanged,
            ),
            const SupportBody(),
            ProfileBody(viewInsets: widget.viewInsets),
          ],
        );
      },
    );
  }
}
