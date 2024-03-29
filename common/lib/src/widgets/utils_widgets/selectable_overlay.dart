import 'package:common/src/localization/localizations_ext.dart';
import 'package:common/src/theme/theme_extension.dart';
import 'package:common/src/utils/constants/common_dimensions.dart';
import 'package:common/src/utils/constants/common_fonts.dart';
import 'package:common/src/utils/constants/images_assets.dart';
import 'package:common/src/widgets/input_field/input_field.dart';
import 'package:common/src/widgets/utils_widgets/avtovas_checkbox.dart';
import 'package:common/src/widgets/vector_button/avtovas_vector_button.dart';
import 'package:flutter/material.dart';

final class SelectableOverlay<T> extends StatefulWidget {
  final List<SelectableOverlayItem<T>> items;
  final bool needScroll;
  final bool withCloseButton;
  final bool withSearchField;
  final int? separatedIndex;

  const SelectableOverlay({
    required this.items,
    this.withCloseButton = false,
    this.withSearchField = false,
    this.separatedIndex,
    this.needScroll = false,
    super.key,
  });

  @override
  State<SelectableOverlay<T>> createState() => _SelectableOverlayState<T>();
}

class _SelectableOverlayState<T> extends State<SelectableOverlay<T>> {
  late final ScrollController _scrollController;

  var _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.viewInsetsOf(context).bottom;

    final overlay = Column(
      children: [
        Row(
          children: [
            if (widget.withCloseButton)
              AvtovasVectorButton(
                onTap: () => Navigator.canPop(context)
                    ? Navigator.pop(context)
                    : throw Exception(
                  'This action is related to the Navigator, '
                      'the window must use any overlay to display '
                      'and have a path in the navigator context.',
                ),
                svgAssetPath: ImagesAssets.crossIcon,
              ),
          ],
        ),
        const SizedBox(height: CommonDimensions.large),
        if (widget.needScroll)
          Expanded(
            child: Theme(
              data: context.themeData.copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbVisibility: MaterialStateProperty.all(true),
                  thumbColor: MaterialStateProperty.all(
                    context.theme.mainAppColor,
                  ),
                  crossAxisMargin: -10,
                ),
              ),
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _searchQuery.isEmpty
                    ? widget.items.length
                    : widget.items
                    .where(
                      (item) => item.itemLabel
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()),
                )
                    .length,
                separatorBuilder: (context, index) {
                  if (widget.separatedIndex != null &&
                      index == widget.separatedIndex) {
                    return const Divider();
                  }

                  return const SizedBox();
                },
                itemBuilder: (_, index) {
                  return _searchQuery.isEmpty
                      ? widget.items[index]
                      : widget.items
                      .where(
                        (item) => item.itemLabel
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()),
                  )
                      .toList()[index];
                },
              ),
            ),
          )
        else
          Column(mainAxisSize: MainAxisSize.min, children: widget.items),
        if (widget.withSearchField && widget.items.length > 10) ...[
          const SizedBox(height: CommonDimensions.large),
          Padding(
            padding: EdgeInsets.only(
              bottom: bottomInsets >= CommonDimensions.mediumLarge
                  ? bottomInsets - CommonDimensions.mediumLarge
                  : CommonDimensions.none,
            ),
            child: InputField(
              onChanged: (value) => setState(
                    () => _searchQuery = value,
              ),
              inputDecoration: InputDecoration(
                contentPadding: const EdgeInsets.all(
                  CommonDimensions.medium,
                ),
                border: const OutlineInputBorder(),
                hintText: context.locale.search,
              ),
            ),
          ),
        ],
      ],
    );

    return widget.needScroll ? Expanded(child: overlay) : overlay;
  }
}

final class SelectableOverlayItem<T> extends StatelessWidget {
  final ValueChanged<T> onItemChanged;
  final String itemLabel;
  final T item;
  final T selectedItem;

  const SelectableOverlayItem({
    required this.onItemChanged,
    required this.itemLabel,
    required this.item,
    required this.selectedItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.transparent,
      child: InkWell(
        onTap: () {
          onItemChanged(item);
          Navigator.canPop(context)
              ? Navigator.pop(context)
              : throw Exception(
                  'This action is related to the Navigator, '
                  'the window must use any overlay to display '
                  'and have a path in the navigator context.',
                );
        },
        borderRadius: const BorderRadius.all(
          Radius.circular(CommonDimensions.medium),
        ),
        child: Padding(
          padding: const EdgeInsets.all(CommonDimensions.large),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  itemLabel,
                  style: context.themeData.textTheme.titleLarge?.copyWith(
                    fontSize: CommonFonts.sizeHeadlineMedium,
                  ),
                ),
              ),
              const SizedBox(width: CommonDimensions.medium),
              AvtovasCheckbox(
                onChanged: (_) => onItemChanged(item),
                value: item == selectedItem,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
