import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'filters_btn.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({super.key});

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            children: [
              DateFilterBtnWidget()
            ]
        ),
        margin: EdgeInsets.only(
            top: 10
        )
    );
  }
}
