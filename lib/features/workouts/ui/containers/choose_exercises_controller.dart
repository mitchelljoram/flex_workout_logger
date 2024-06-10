import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/exercise.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/set.entity.dart';
import 'package:flex_workout_logger/ui/widgets/bubbles.dart';
import 'package:flex_workout_logger/ui/widgets/entity_list_tiles.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ChooseExercisesController extends ConsumerStatefulWidget {
  final void Function(List<ExerciseEntity>) onChanged;
  final List<ExerciseEntity> initialExercises;

  const ChooseExercisesController({
    required this.onChanged,
    required this.initialExercises,
    super.key,
  });

  @override
  ConsumerState<ChooseExercisesController> createState() => _ChooseExercisesControllerState();
}

class _ChooseExercisesControllerState extends ConsumerState<ChooseExercisesController> {

  List<ExerciseEntity> _exercises = [];

  @override
  void initState() {
    _exercises = widget.initialExercises.toList();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  void _onAddExercise(ExerciseEntity exerciseToAdd) {
  }

  void _onRemoveExercise(ExerciseEntity exerciseToRemove) {
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._exercises.map((e) => 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    e.exercise!.name,
                    style: context.textTheme.bodyLarge.copyWith(
                      color: context.colorScheme.foregroundPrimary,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {}, 
                    icon: const Icon(
                      CupertinoIcons.ellipsis_circle,
                    ),
                    color: context.colorScheme.foregroundSecondary,
                    iconSize: 24,
                  )
                ],
              ),
              SizedBox(
                height: AppLayout.smallPadding,
              ),
              SetsCard(
                label: 'Warmup',
                initialSets: e.warmupSets,
              ),
              SizedBox(
                height: AppLayout.smallPadding,
              ),
              SetsCard(
                label: 'Working',
                initialSets: e.workingSets,
              ),
            ],
          )
        ),
        SizedBox(
          height: AppLayout.defaultPadding,
        ),
        BubbleIconButton(
          label: 'Add Exercise',
          backgroundColor: context.colorScheme.backgroundTertiary, 
          icon: CupertinoIcons.add, 
          onTap: () async {}
        ),
      ],
    );
  }
}

class SetsCard extends StatefulWidget {

  SetsCard({
    required this.label, 
    required this.initialSets,
    super.key,
  });

  final String label;

  final List<SetEntity> initialSets;

  @override
  State<SetsCard> createState() => _SetsCardState();
}

class _SetsCardState extends State<SetsCard> {

  List<SetEntity> _sets = [];

  @override
  void initState() {
    _sets = widget.initialSets.toList();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  void _onAddSet(SetEntity setToAdd) {
  }

  void _onRemoveSet(SetEntity setToRemove) {
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.backgroundTertiary,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.all(AppLayout.miniPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: context.textTheme.labelLarge.copyWith(
              color: context.colorScheme.foregroundPrimary,
            ),
          ),
          SizedBox(
            width: AppLayout.defaultPadding,
          ),
          ..._sets.map((s) {
            index++;

            return Column(
              children: [
                SetListTile(
                  set: s, 
                  index: index,
                  editOnTap: () {},
                  duplicateOnTap: () {},
                  removeOnTap: () {},
                ),
                Divider(
                  indent: AppLayout.extraLargePadding,
                ),
              ]
            );
          }),
          SizedBox(
            width: AppLayout.miniPadding,
          ),
          BubbleIconButton(
            label: 'Add Set',
            backgroundColor: context.colorScheme.foregroundQuaternary, 
            icon: CupertinoIcons.add, 
            onTap: () {}
          ),
        ]
      ),
    );
  }
}
