import 'package:common/avtovas_common.dart';
import 'package:common/src/utils/constants/common_fonts.dart';
import 'package:flutter/material.dart';

// ignore_for_file: implementation_imports

class AvtovasAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? svgAssetPath;
  final VoidCallback onTap;

  const AvtovasAppBar({
    required this.title,
    required this.onTap,
    this.svgAssetPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.mainAppColor,
      leading: svgAssetPath == null
          ? AvtovasVectorButton(
              onTap: onTap,
              svgAssetPath: svgAssetPath!,
            )
          : const SizedBox(),
      title: Text(
        title,
        style: context.themeData.textTheme.displaySmall?.copyWith(
          color: context.theme.whitespaceContainerColor,
          fontWeight: CommonFonts.weightRegular,
          fontSize: CommonFonts.appBarFontSize,
        ),
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
