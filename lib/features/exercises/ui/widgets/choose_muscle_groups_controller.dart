import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/autofill_segment_controller.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ChooseMuscleGroupsController extends StatefulWidget {
  final void Function(List<MuscleGroupEntity>, List<MuscleGroupEntity>) onChanged;
  final List<MuscleGroupEntity> initialPrimaryMuscleGroups;
  final List<MuscleGroupEntity> initialSeconadryMuscleGroups;
  final MovementPatternEntity? movementPattern;

  const ChooseMuscleGroupsController({
    required this.onChanged,
    required this.initialPrimaryMuscleGroups,
    required this.initialSeconadryMuscleGroups,
    required this.movementPattern,
    super.key,
  });

  @override
  State<ChooseMuscleGroupsController> createState() => _ChooseMuscleGroupsControllerState();
}

class _ChooseMuscleGroupsControllerState extends State<ChooseMuscleGroupsController> {

  List<MuscleGroupEntity> _primaryMuscleGroups = [];
  List<MuscleGroupEntity> _seconadryMuscleGroups = [];
  MovementPatternEntity? _movementPattern;

  @override
  void initState() {
    _primaryMuscleGroups = widget.initialPrimaryMuscleGroups;
    _seconadryMuscleGroups = widget.initialSeconadryMuscleGroups;
    _movementPattern = widget.movementPattern;
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  void _onAutofillChanged(int index) {
    setState(() {
      if (index == 2) {
        _primaryMuscleGroups = _movementPattern!.primaryMuscleGroups;
        _seconadryMuscleGroups = _movementPattern!.secondaryMuscleGroups;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Autofill muscle groups based on the movement pattern?',
          style: context.textTheme.headlineMedium,
        ),
        const SizedBox(height: AppLayout.smallPadding),
        AutofillSegementedController(
          selectedValue: 1,
          onValueChanged: _onAutofillChanged,
        ),
        const SizedBox(height: AppLayout.defaultPadding),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/muscle_groups/front.svg',
                    height: 240,
                  ),
                  SvgPicture.asset(
                    'assets/muscle_groups/front/Biceps.svg',
                    colorFilter: ColorFilter.mode(context.colorScheme.pink, BlendMode.srcIn),
                    height: 240,
                  ),
                  SvgPicture.asset(
                    'assets/muscle_groups/front/Quadriceps.svg',
                    colorFilter: ColorFilter.mode(context.colorScheme.pink, BlendMode.srcIn),
                    height: 240,
                  ),
                ],
              ),
              const SizedBox(width: AppLayout.largePadding),
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/muscle_groups/back.svg',
                    height: 240,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.defaultPadding),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Primary Muscle Groups',
                style: context.textTheme.labelMedium.copyWith(
                  color: context.colorScheme.foregroundPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.defaultPadding),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Secondary Muscle Groups',
                style: context.textTheme.labelMedium.copyWith(
                  color: context.colorScheme.foregroundPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<List<MuscleGroupEntity>?> _showPrimaryBottomSheet<String>(
  BuildContext context,
  List<MuscleGroupEntity> muscleGroups,
  List<MuscleGroupEntity> primary,
  List<MuscleGroupEntity> secondary,
) {
  return showModalBottomSheet(
    context: context, 
    showDragHandle: true,
    scrollControlDisabledMaxHeightRatio: 0.9,
    elevation: 0,
    constraints: BoxConstraints(
      minWidth: double.infinity,           
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => Wrap(
      children: muscleGroups.map((c) => Container(
      )).toList(),
    )
  );
}

Future<List<MuscleGroupEntity>?> _showSecondaryBottomSheet<String>(
  BuildContext context,
  List<MuscleGroupEntity> muscleGroups,
  List<MuscleGroupEntity> primary,
  List<MuscleGroupEntity> secondary,
) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    elevation: 0,
    constraints: BoxConstraints(
      minWidth: double.infinity,            
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => Wrap(
      children: muscleGroups.map((c) => Container(
      )).toList(),
    )
  );
}