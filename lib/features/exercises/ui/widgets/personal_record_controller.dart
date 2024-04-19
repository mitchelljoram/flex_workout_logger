
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/ui/widgets/weight_input.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalRecordController extends StatelessWidget {
  /// Constructor
  PersonalRecordController();

  @override
  Widget build(BuildContext context) {
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
          onChanged: (value, unit) {},
          hintText: '3 - 5', 
          readOnly: false
        ),
        const SizedBox(
          height: AppLayout.defaultPadding,
        ),
        WeightInput(
          label: '10 RM', 
          onChanged: (value, unit) {},
          hintText: '3 - 5', 
          readOnly: false
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