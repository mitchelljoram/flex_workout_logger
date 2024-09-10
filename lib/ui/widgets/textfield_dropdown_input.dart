import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/ui/widgets/enum_dropdown_menu.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TextfieldDropdownInput extends StatefulWidget {
  TextfieldDropdownInput({
    required this.label,
    required this.textfieldHintText,
    required this.dropdownHintText,
    required this.dropdownEntries,
    required this.validator,
    required this.onChanged,
    required this.readOnly,
    super.key,
    this.initialUnit,
    this.initialValue,
  });

  /// Label
  final String label;

  /// Hint Texts
  final String textfieldHintText;
  final String dropdownHintText;

  /// Initial Values
  final String? initialValue;
  final Enumeration? initialUnit;

  /// Dropdown Entries
  final List<Enumeration> dropdownEntries;

  /// Validator
  final String? Function(String?) validator;

  /// On Changed
  final void Function(String?, Enumeration?) onChanged;

  /// Read Only
  final bool readOnly;

  @override
  State<TextfieldDropdownInput> createState() => _TextfieldDropdownInputState();
}

class _TextfieldDropdownInputState extends State<TextfieldDropdownInput> {
  /// Weight Input
  late String _value;

  /// Selected Weight Unit
  late Enumeration? _selectedUnit;

  /// Controller
  final _controller = new TextEditingController();

  @override
  void initState() {
    _value = widget.initialValue ?? '';
    _selectedUnit = widget.initialUnit;
    _controller.text = _value;
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// On Value Input Change
    void _onValueChanged(String value) {
      // TODO: Add validation check
      setState(() {
        _value = value;

        widget.onChanged(_value, _selectedUnit);
      });
    }

    void _onUnitChanged(Enumeration? unit) {
      setState(() {
        _selectedUnit = unit;

        widget.onChanged(_value, _selectedUnit);
      });
    }

    return Column(
      children: [
        Row(
          children: [
            Text(widget.label, style: context.textTheme.labelMedium),
            Spacer(),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextFormField(
                controller:  _controller,
                onChanged: (String value) => {
                  _onValueChanged(value)
                },
                validator: (value) => widget.validator(value),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                readOnly: widget.readOnly,
                maxLines: 1,
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: widget.textfieldHintText,
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
            EnumDropdownMenu( 
              hintText: widget.dropdownHintText, 
              width: MediaQuery.of(context).size.width * 0.45, 
              dropdownEntries: widget.dropdownEntries, 
              initalEntry: widget.initialUnit,
              onChanged: _onUnitChanged,
              isDisabled: false
            )
          ],
        )
      ],
    );
  }
}
