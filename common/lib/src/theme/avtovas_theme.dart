import 'dart:ui';

import 'package:equatable/equatable.dart';

final class AvtovasTheme extends Equatable {
  final bool isDark;

  final Color mainAppColor;
  final Color detailsBackgroundColor;
  final Color whitespaceContainerColor;
  final Color dividerColor;

  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color tertiaryTextColor;
  final Color quaternaryTextColor;
  final Color fivefoldTextColor;

  final Color assistiveTextColor;

  final String fontFamily;

  @override
  List<Object?> get props => [
        isDark,
        mainAppColor,
        detailsBackgroundColor,
        whitespaceContainerColor,
        dividerColor,
        primaryTextColor,
        secondaryTextColor,
        tertiaryTextColor,
        quaternaryTextColor,
        fivefoldTextColor,
        assistiveTextColor,
        fontFamily,
      ];

  const AvtovasTheme({
    required this.isDark,
    required this.mainAppColor,
    required this.detailsBackgroundColor,
    required this.whitespaceContainerColor,
    required this.dividerColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.tertiaryTextColor,
    required this.quaternaryTextColor,
    required this.fivefoldTextColor,
    required this.assistiveTextColor,
    required this.fontFamily,
  });
}