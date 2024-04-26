
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/personal_record.entity.dart';
import 'package:flex_workout_logger/ui/widgets/weight_input.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalRecordController extends StatelessWidget {
  final PersonalRecordEntity? initialValue;
  final void Function(PersonalRecordEntity) onChanged;

  /// Constructor
  PersonalRecordController({
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    double oneRepMaxKgs = 0.0;
    double oneRepMaxLbs = 0.0;
    double tenRepMaxKgs = 0.0;
    double tenRepMaxLbs = 0.0;

    WeightUnits initial1RMUnit = WeightUnits.kilograms;
    WeightUnits initial10RMUnit = WeightUnits.kilograms;

    if (initialValue != null) {
      oneRepMaxKgs = initialValue!.oneRepMaxEstimateKgs;
      oneRepMaxLbs = initialValue!.oneRepMaxEstimateLbs;
      tenRepMaxKgs = initialValue!.tenRepMaxEstimateKgs;
      tenRepMaxLbs = initialValue!.tenRepMaxEstimateLbs;

      if (oneRepMaxLbs != 0) {
        initial1RMUnit = WeightUnits.pounds;
      }
      if (tenRepMaxLbs != 0) {
        initial10RMUnit = WeightUnits.pounds;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        const SizedBox(
          height: AppLayout.smallPadding,
        ),
        Text(
          'Current Training Maxes',
          style: context.textTheme.labelMedium.copyWith(
            color: context.colorScheme.foregroundPrimary,
          ),
        ),
        const SizedBox(
          height: AppLayout.defaultPadding,
        ),
        WeightInput(
          label: '1 RM', 
          onChanged: (value, unit) {
            if (unit == WeightUnits.kilograms) {
              oneRepMaxKgs = double.parse(value.toStringAsFixed(2));
              oneRepMaxLbs = 0.0;
              // oneRepMaxLbs = double.parse((value * 2.205).toStringAsFixed(2));
            } else {
              oneRepMaxLbs = double.parse(value.toStringAsFixed(2));
              oneRepMaxKgs = 0.0;
              // oneRepMaxKgs = double.parse((value / 2.205).toStringAsFixed(2));
            }

            onChanged(
              PersonalRecordEntity(
                oneRepMaxEstimateKgs: oneRepMaxKgs,
                oneRepMaxEstimateLbs: oneRepMaxLbs,
                tenRepMaxEstimateKgs: tenRepMaxKgs,
                tenRepMaxEstimateLbs: tenRepMaxLbs,
                createdAt: DateTimeX.current,
                updatedAt: DateTimeX.current,
              )
            );
          },
          hintText: 'One Rep Max', 
          readOnly: false,
          initialWeight: initial1RMUnit == WeightUnits.kilograms ? oneRepMaxKgs : oneRepMaxLbs,
          initialUnit: initial1RMUnit,
        ),
        const SizedBox(
          height: AppLayout.defaultPadding,
        ),
        WeightInput(
          label: '10 RM', 
          onChanged: (value, unit) {
            if (unit == WeightUnits.kilograms) {
              tenRepMaxKgs = value;
              tenRepMaxLbs = 0.0;
            } else {
              tenRepMaxLbs = value;
              tenRepMaxKgs = 0.0;
            }

            onChanged(
              PersonalRecordEntity(
                oneRepMaxEstimateKgs: oneRepMaxKgs,
                oneRepMaxEstimateLbs: oneRepMaxLbs,
                tenRepMaxEstimateKgs: tenRepMaxKgs,
                tenRepMaxEstimateLbs: tenRepMaxLbs,
                createdAt: DateTimeX.current,
                updatedAt: DateTimeX.current,
              )
            );
          },
          hintText: 'Ten Rep Max', 
          readOnly: false,
          initialWeight: initial10RMUnit == WeightUnits.kilograms ? tenRepMaxKgs : tenRepMaxLbs,
          initialUnit: initial10RMUnit,
        ),
        const SizedBox(
          height: AppLayout.defaultPadding,
        ),
        Container(
          width: MediaQuery.of(context).size.width - (AppLayout.defaultPadding * 2),
          color: context.colorScheme.backgroundPrimary,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.defaultPadding,
              vertical: AppLayout.defaultPadding,
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.info_circle,
                ),
                const SizedBox(
                  width: AppLayout.defaultPadding,
                ),
                Expanded(
                  child: Text(
                    'Training maxes are optional and will only be used to calculate intensity as well as track progress.',
                    style: context.textTheme.bodySmall.copyWith(
                      color: context.colorScheme.foregroundSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}