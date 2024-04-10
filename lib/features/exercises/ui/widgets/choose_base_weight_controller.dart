import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseBaseWeightController extends StatefulWidget {
  final BaseWeightEntity? initialValue;
  final void Function(BaseWeightEntity) onChanged;

  const ChooseBaseWeightController({
    this.initialValue,
    required this.onChanged,
    super.key,
  });

  @override
  State<ChooseBaseWeightController> createState() => _ChooseBaseWeightControllerState();
}

class _ChooseBaseWeightControllerState extends State<ChooseBaseWeightController> {
  BaseWeightEntity? _baseWeight;
  WeightUnits _weightUnit = WeightUnits.pounds;
  String _bottomText = '';

  @override
  void initState() {
    if (widget.initialValue != null) {
      _baseWeight = widget.initialValue;
    }
    else {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Base Weight',
                  style: context.textTheme.labelMedium.copyWith(
                    color: context.colorScheme.foregroundPrimary,
                  ),
                ),
                const SizedBox(
                  height: AppLayout.extraMiniPadding,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - (AppLayout.defaultPadding * 6),
                  child: Text(
                    'Used for equipment with inherent weight not counted in load. For example, body weight in pull-ups, sled weight in leg press.',
                    style: context.textTheme.labelSmall.copyWith(
                      color: context.colorScheme.foregroundSecondary,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _baseWeight!.weightLbs.toString(),
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
                Text(
                  _bottomText,
                  style: context.textTheme.labelMedium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.foregroundSecondary,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: AppLayout.defaultPadding,
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.backgroundTertiary,
            borderRadius: BorderRadius.circular(999)
          ),
          child: InkWell(
            onTap:() async {
              // var res = await _showBaseWeightBottomSheet(context, _icons);

              // if (res == null) return;

              // _onChanged(res);
            },
            borderRadius: BorderRadius.circular(25),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppLayout.defaultPadding,
                vertical: AppLayout.extraMiniPadding
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    size: 12,
                    color: context.colorScheme.foregroundPrimary,
                  ),
                  const SizedBox(
                    width: AppLayout.smallPadding,
                  ),
                  Text(
                    'Setup Base Weight',
                    style: context.textTheme.bodySmall.copyWith(
                      color: context.colorScheme.foregroundPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}