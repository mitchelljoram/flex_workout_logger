import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnumDropdownMenu extends StatefulWidget{

  EnumDropdownMenu({
    required this.labelText,
    required this.hintText,
    required this.width,
    required this.dropdownEntries,
    required this.initalEntry,
    required this.isWarmup,
  });

  final String labelText;
  final String hintText;

  final double width;

  final List<Enumeration> dropdownEntries;
  final Enumeration? initalEntry;

  final bool isWarmup;

  @override
  State<EnumDropdownMenu> createState() => _EnumDropdownMenuState();
}

class _EnumDropdownMenuState extends State<EnumDropdownMenu> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText ?? 'Select',
          style: context.textTheme.labelMedium.copyWith(
            color: context.colorScheme.foregroundPrimary,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        if (widget.isWarmup)
          Container(
            padding: const EdgeInsets.all(AppLayout.smallPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: context.colorScheme.backgroundTertiary,
            ),
            width: widget.width,
            child: Text(
              'Warmup',
              style: context.textTheme.bodyMedium.copyWith(
                color: context.colorScheme.foregroundSecondary,
              ),
            ),
          )
        else
          DropdownMenu(
            dropdownMenuEntries: widget.dropdownEntries.map((e) => 
              DropdownMenuEntry(
                value: e, 
                label: e.name
              )
            ).toList(),
            onSelected: (value) {},
            initialSelection: widget.initalEntry,
            hintText: widget.hintText,
            menuHeight: MediaQuery.sizeOf(context).height * 0.2,
            width: widget.width,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: context.colorScheme.backgroundTertiary,
              contentPadding: const EdgeInsets.all(AppLayout.smallPadding),
              constraints: BoxConstraints(
                maxHeight: 40
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: context.colorScheme.foregroundSecondary,
                  width: 1,
                )
              ),
            ),
            textStyle: context.textTheme.bodyMedium,
            menuStyle: MenuStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (states) => context.colorScheme.backgroundTertiary,
              ),
            ),
            trailingIcon: Icon(
              CupertinoIcons.chevron_down,
              color: context.colorScheme.foregroundSecondary,
            ),
            selectedTrailingIcon: Icon(
              CupertinoIcons.chevron_up,
              color: context.colorScheme.foregroundSecondary,
            ),           
          ),
      ],
    );
  }
}