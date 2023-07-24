import 'package:common/avtovas_common.dart';
import 'package:common/src/utils/constants/common_dimensions.dart';
import 'package:flutter/material.dart';

// ignore_for_file: implementation_imports

class ContactInfoRow extends StatelessWidget {
  final String svgAssetPath;
  final String label;

  const ContactInfoRow({
    required this.svgAssetPath,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: CommonDimensions.medium),
      child: Row(
        children: [
          AvtovasVectorImage(svgAssetPath: svgAssetPath),
          const SizedBox(width: CommonDimensions.large),
          Text(
            label,
            style: context.themeData.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}