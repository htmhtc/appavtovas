import 'package:avtovas_mobile/features/utils/constants/dimensions.dart';
import 'package:avtovas_mobile/features/utils/constants/colors.dart';
import 'package:common/avtovas_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common/src/utils/constants/images_assets.dart';

class DateFilterBtnWidget extends StatefulWidget {
  const DateFilterBtnWidget({super.key});

  @override
  State<DateFilterBtnWidget> createState() => _DateFilterBtnWidgetState();
}

class _DateFilterBtnWidgetState extends State<DateFilterBtnWidget> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            maximumSize: MaterialStateProperty.all<Size>(
              Size(
                  Dimensions.datePickerBtnWidth,
                  Dimensions.datePickerBtnHeight
              )
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(
                Dimensions.datePickerBtnWidth,
                Dimensions.datePickerBtnHeight
              )
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      Dimensions.datePickerBtnRadius
                  ),
                )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                SearchColors.datePickerBtnBackground
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
                SearchColors.datePickerBtnForeground
            )
        ),
        onPressed: () {
          // TODO
          AvtovasDatepickerUtils.showAutovasDatePicker(context: context);
        },
        child: Container(
            child: Row(
                children: [
                  AvtovasVectorImage(
                    svgAssetPath: ImagesAssets.datePickerIcon
                  ),
                  Container(
                    child: Text(context.locale.date),
                    margin: EdgeInsets.only(
                      left: Dimensions.dateBtnLabelMarginLeft
                    ),
                  )
                ]
            )
        )
    );
  }
}
