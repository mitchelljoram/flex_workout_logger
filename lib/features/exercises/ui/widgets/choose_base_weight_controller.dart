import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
import 'package:flex_workout_logger/ui/widgets/bubbles.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseBaseWeightController extends StatefulWidget {
  final BaseWeightEntity? initialValue;
  final void Function(BaseWeightEntity) onChanged;
  final void Function() handleFlowBaseWeight;

  const ChooseBaseWeightController({
    this.initialValue,
    required this.onChanged,
    required this.handleFlowBaseWeight,
    super.key,
  });

  @override
  State<ChooseBaseWeightController> createState() => _ChooseBaseWeightControllerState();
}

class _ChooseBaseWeightControllerState extends State<ChooseBaseWeightController> {
  BaseWeightEntity? _baseWeight;
  WeightUnits _weightUnit = WeightUnits.kilograms;

  @override
  void initState() {
    if (widget.initialValue != null) {
      _baseWeight = widget.initialValue;

      if (_baseWeight!.weightKgs == 0.0 && _baseWeight!.weightLbs != 0.0) {
        _weightUnit = WeightUnits.pounds;
      }
    } else {
      _baseWeight = BaseWeightEntity(
        weightKgs: 0.0,
        weightLbs: 0.0,
        assisted: false, 
        bodyWeight: false,
        createdAt: DateTimeX.current, 
        updatedAt: DateTimeX.current
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Base Weight',
          style: context.textTheme.labelMedium.copyWith(
            color: context.colorScheme.foregroundPrimary,
          ),
        ),
        Text(
          'Used for equipment with inherent weight not counted in load. For example, body weight in pull-ups, sled weight in leg press.',
          style: context.textTheme.labelSmall.copyWith(
            color: context.colorScheme.foregroundSecondary,
          ),
        ),
        const SizedBox(
          height: AppLayout.defaultPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  _baseWeight!.weightKgs != 0.0 ? _baseWeight!.weightKgs.toString() : _baseWeight!.weightLbs.toString(),
                  style: context.textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.foregroundPrimary,
                  ),
                ),
                const SizedBox(
                  width: AppLayout.extraMiniPadding,
                ),
                Text(
                  _weightUnit.name,
                  style: context.textTheme.labelMedium.copyWith(
                    color: context.colorScheme.foregroundSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: AppLayout.largePadding,
            ),
            if (_baseWeight!.assisted)
              Row(
                children: [
                  Text(
                    '• Assisted',
                    style: context.textTheme.labelMedium.copyWith(
                      color: context.colorScheme.foregroundSecondary,
                    ),
                  ),
                  SizedBox(
                    width: AppLayout.defaultPadding,
                  ),
                ],
              ),
            if (_baseWeight!.bodyWeight)
              Text(
                '• Bodyweight',
                style: context.textTheme.labelMedium.copyWith(
                  color: context.colorScheme.foregroundSecondary,
                ),
              ),
          ],
        ),
        const SizedBox(
          height: AppLayout.defaultPadding,
        ),
        BubbleIconButton(
          label: 'Setup Base Weight', 
          backgroundColor: context.colorScheme.backgroundTertiary, 
          icon: CupertinoIcons.add, 
          onTap: () {
            widget.handleFlowBaseWeight();
          },
        ),
      ],
    );
  }
}