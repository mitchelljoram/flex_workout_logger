import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlexableRadioList<T extends Enumeration<Enum>> extends StatefulWidget {
  final List<T> items;
  final ValueChanged<T?> onSelected;
  final T? selectedValue;
  final String labelText;
  final String? description;

  const FlexableRadioList({
    required this.items,
    required this.onSelected,
    required this.selectedValue,
    required this.labelText,
    this.description,
    super.key,
  });

  @override
  State<FlexableRadioList> createState() => _FlexableRadioListState();
}

class _FlexableRadioListState extends State<FlexableRadioList> {
  List<RadioModel> items = [];

  @override
  void initState() {
    widget.items.forEach((i) {
      items.add(new RadioModel(i == widget.selectedValue ? true : false, i));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: context.textTheme.labelMedium.copyWith(
            color: context.colorScheme.foregroundPrimary,
          ),
        ),
        const SizedBox(
          height: AppLayout.extraMiniPadding,
        ),
        if (widget.description != null)
          Text(
            widget.description!,
            style: context.textTheme.labelSmall.copyWith(
              color: context.colorScheme.foregroundSecondary,
            ),
          ),
        const SizedBox(
          height: AppLayout.extraMiniPadding,
        ),
        ...items.map((i) => Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  items.forEach((e) => e.isSelected = false);
                  i.isSelected = true;
                });

                widget.onSelected(i.value);
              },
              child: RadioItem(i),
            ),
            if (i != items[items.length - 1])
              const Divider(
                indent: AppLayout.largePadding,
              ),
          ]
        ))
      ],
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        _item.value.name,
        style: context.textTheme.labelLarge.copyWith(
          color: context.colorScheme.foregroundPrimary,
        ),
      ),
      subtitle: _item.value.description != null ?
        Padding(
          padding: EdgeInsets.only(
            right: AppLayout.largePadding,
          ),
          child: Text(
            _item.value.description!,
            maxLines: 3,
            style: context.textTheme.labelSmall.copyWith(
              color: context.colorScheme.foregroundSecondary,
            ),
          )
        ) :
        null,
      trailing: _item.isSelected ?
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 10, color: context.colorScheme.foregroundPrimary)
          ),
        ) : 
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 4, color: context.colorScheme.foregroundTertiary)
          ),
        ),
      padding: const EdgeInsets.fromLTRB(
        AppLayout.largePadding,
        AppLayout.extraMiniPadding,
        AppLayout.extraMiniPadding,
        AppLayout.extraMiniPadding,
      ),
    );
  }
}

class RadioModel<T extends Enumeration<Enum>> {
  bool isSelected;
  final T value;

  RadioModel(this.isSelected, this.value);
}