import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

///
class VariationSegementedController extends StatelessWidget {
  /// Constructor
  const VariationSegementedController({
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  /// Initial Value
  final int selectedValue;

  /// Value Changed Callback
  final void Function(int) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      initialValue: selectedValue,
      padding: AppLayout.defaultPadding,
      height: 34,
      isStretch: true,
      fromMax: true,
      children: {
        1: Text(
          'New Exercise',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: selectedValue == 1
                ? context.colorScheme.backgroundPrimary
                : context.colorScheme.foregroundPrimary,
          ),
        ),
        2: Text(
          'Variation',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: selectedValue == 2
                ? context.colorScheme.backgroundPrimary
                : context.colorScheme.foregroundPrimary,
          ),
        ),
      },
      decoration: BoxDecoration(
        color: context.colorScheme.backgroundTertiary,
        borderRadius: BorderRadius.circular(999),
      ),
      thumbDecoration: BoxDecoration(
        color: context.colorScheme.foregroundPrimary,
        borderRadius: BorderRadius.circular(999),
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      onValueChanged: onValueChanged,
      customSegmentSettings:
          // ignore: avoid_redundant_argument_values
          CustomSegmentSettings(splashColor: Colors.transparent),
    );
  }
}
