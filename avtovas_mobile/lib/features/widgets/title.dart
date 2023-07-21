import 'package:common/avtovas_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avtovas_mobile/features/utils/constants/colors.dart';
import 'package:avtovas_mobile/features/utils/constants/dimensions.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {

  @override
  Widget build(BuildContext context) {
    return Text(
        context.locale.title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: SearchColors.titleColor,
            fontSize: Dimensions.titleSize
        )
    );
  }
}
