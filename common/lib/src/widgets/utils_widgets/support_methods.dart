import 'package:common/avtovas_common.dart';
import 'package:common/src/theme/theme_extension.dart';
import 'package:common/src/utils/constants/common_dimensions.dart';
import 'package:common/src/utils/constants/images_assets.dart';
import 'package:common/src/widgets/vector_button/avtovas_vector_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class SupportMethods {
  static Future<void> showAvtovasDialog({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    Color barrierColor = kCupertinoModalBarrierColor,
    bool useRootNavigator = false,
    bool userSafeArea = true,
    bool barrierDismissible = true,
  }) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => barrierDismissible ? Navigator.pop(context) : null,
          child: Material(
            color: context.theme.transparent,
            child: GestureDetector(
              onTap: () {},
              child: builder(context),
            ),
          ),
        );
      },
      useRootNavigator: useRootNavigator,
    );
  }

  static Future<void> showAvtovasBottomSheet({
    required BuildContext context,
    required Widget child,
    BoxConstraints? constraints,
    String? sheetTitle,
    TextStyle? titleStyle,
    bool useCloseButton = true,
    bool useRootNavigator = false,
    Color barrierColor = kCupertinoModalBarrierColor,
  }) async {
    await showModalBottomSheet(
      context: context,
      constraints: constraints ??
          (AvtovasPlatform.isWeb
              ? BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                  maxHeight: MediaQuery.sizeOf(context).height * 0.7,
                )
              : constraints),
      backgroundColor: context.theme.transparent,
      useRootNavigator: useRootNavigator,
      barrierColor: barrierColor,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(bottom: CommonDimensions.large),
          child: Material(
            borderRadius: const BorderRadius.all(
              Radius.circular(CommonDimensions.large),
            ),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.all(CommonDimensions.large),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (sheetTitle != null || useCloseButton) ...[
                      Row(
                        children: [
                          if (sheetTitle != null)
                            Text(
                              sheetTitle,
                              style: titleStyle ??
                                  context.themeData.textTheme.displaySmall,
                            ),
                          const Spacer(),
                          if (useCloseButton)
                            AvtovasVectorButton(
                              onTap: () => Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : throw Exception(),
                              svgAssetPath: ImagesAssets.crossIcon,
                            ),
                        ],
                      ),
                      const SizedBox(height: CommonDimensions.medium),
                    ],
                    child,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<DateTime?> showAvtovasDatePicker(
    BuildContext context,
    Future<DateTime?> dateTime,
  ) async {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // _overlayCubit.applyStyle(
    //   _overlayCubit.state.style!.copyWith(
    //     systemNavigationBarColor: context.theme.transparent,
    //   ),
    // );

    final pickedDate = await dateTime;

    // _overlayCubit.applyPreviousStyle();
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: SystemUiOverlay.values,
    // );

    return pickedDate;
  }
}
