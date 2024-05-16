import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

/// Custom text field
class FlexableTextField extends StatelessWidget {
  /// Constructor
  const FlexableTextField({
    required this.label,
    required this.controller,
    required this.onChanged,
    required this.validator,
    required this.hintText,
    required this.errorText,
    required this.readOnly,
    super.key,
    this.isRequired,
    this.isTextArea,
    this.maxLength,
    this.autoFocus,
  });

  /// Label
  final String label;

  /// Hint Text
  final String hintText;

  /// Error Text
  final String? errorText;

  /// On Changed
  final void Function(String) onChanged;

  /// Validator
  final String? Function(String?) validator;

  /// Controller
  final TextEditingController? controller;

  /// Max Length
  final int? maxLength;

  /// Read Only
  final bool readOnly;

  /// Auto Focus
  final bool? autoFocus;

  /// Is Field Required
  final bool? isRequired;

  /// Is Text Area
  final bool? isTextArea;

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
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          readOnly: readOnly,
          autofocus: autoFocus ?? false,
          maxLines: isTextArea != null && isTextArea! ? null : 1,
          minLines: isTextArea != null && isTextArea! ? 5 : 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            isCollapsed: true,
            hintText: hintText,
            errorText: errorText,
            hintMaxLines: isTextArea != null && isTextArea! ? 5 : 1,
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
      ],
    );
  }
}
