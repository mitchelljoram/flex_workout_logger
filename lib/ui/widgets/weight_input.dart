import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom text field
class WeightInput<T extends Enumeration<Enum>> extends StatelessWidget {
  /// Constructor
  WeightInput({
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.controller,
    required this.onChanged,
    required this.validator,
    required this.hintText,
    required this.readOnly,
    super.key,
    this.isRequired,
    this.autoFocus,
  });

  /// Label
  final String label;

  /// Hint Text
  final String hintText;

  final List<T> items;

  final T? selectedValue;

  /// On Changed
  final void Function(String) onChanged;

  final ValueChanged<T?> onSelected = (value) {};

  /// Validator
  final String? Function(String?) validator;

  /// Controller
  final TextEditingController? controller;

  /// Read Only
  final bool readOnly;

  /// Auto Focus
  final bool? autoFocus;

  /// Is Field Required
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(label, style: context.textTheme.labelMedium),
            const Spacer(),
            if (isRequired != null && isRequired!)
              Text(
                'Required',
                style: context.textTheme.labelSmall.copyWith(
                  color: context.colorScheme.foregroundSecondary,
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextFormField(
                controller: controller,
                onChanged: onChanged,
                validator: validator,
                readOnly: readOnly,
                autofocus: autoFocus ?? false,
                maxLines: 1,
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: hintText,
                  hintMaxLines: 1,
                  hintStyle: context.textTheme.bodyMedium.copyWith(
                    color: context.colorScheme.foregroundSecondary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: context.colorScheme.backgroundTertiary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border style when the field is focused
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: context.colorScheme.foregroundPrimary,
                      width: 2,
                    ),
                  ), // Enable filling of the text field
                  contentPadding: const EdgeInsets.all(AppLayout.smallPadding),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextButton(
                onPressed: () async {
                  // var res = await _showBottomSheet(
                  //   state.context,
                  //   items,
                  //   selectedItem,
                  //   canCreate: canCreate,
                  // );

                  // if (res == null) return;

                  // onSelected(res as T);

                  // state.didChange(res);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero, // Set minimum size to zero
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.colorScheme.backgroundTertiary,
                  ),
                  child: Row(
                    children: [
                      Text(
                        items[0].name,
                        style: context.textTheme.bodyMedium.copyWith(
                          color: context.colorScheme.foregroundPrimary,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        CupertinoIcons.chevron_down,
                        color: context.colorScheme.foregroundSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
