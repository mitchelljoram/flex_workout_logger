import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/exercise.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/set.entity.dart';
import 'package:flex_workout_logger/ui/widgets/bubbles.dart';
import 'package:flex_workout_logger/ui/widgets/entity_list_tiles.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
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

  List<ExerciseEntity> _chosenExercises = [];

  @override
  void initState() {
    _chosenExercises = widget.initialExercises.toList();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  void _onAddExercise(ExerciseEntity exerciseToAdd) {
    setState(() {
      _chosenExercises.add(exerciseToAdd);

      print(_chosenExercises);

      widget.onChanged(_chosenExercises);
    });
  }

  void _onRemoveExercise(ExerciseEntity exerciseToRemove) {
  }

  @override
  Widget build(BuildContext context) {
    final exercises = ref.watch(exercisesListControllerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._chosenExercises.map((e) => 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    e.exercise!.name,
                    style: context.textTheme.bodyLarge.copyWith(
                      color: context.colorScheme.foregroundPrimary,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    CupertinoIcons.ellipsis_circle,
                    color: context.colorScheme.foregroundSecondary,
                    size: 24,
                  )
                ],
              ),
              SizedBox(
                height: AppLayout.miniPadding,
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
              SizedBox(
                height: AppLayout.defaultPadding,
              ),
            ],
          )
        ),
        BubbleIconButton(
          label: 'Add Exercise',
          backgroundColor: context.colorScheme.backgroundTertiary, 
          icon: CupertinoIcons.add, 
          onTap: () async {
            var res = await _showExercisesBottomSheet(
              context, 
              exercises.value!
            );
            
            ExerciseEntity exerciseToAdd = ExerciseEntity(
              exercise: res,
              warmupSets: [],
              workingSets: [],
              notes: '',
              alternatives: [],
              createdAt: DateTimeX.current, 
              updatedAt: DateTimeX.current
            );

            _onAddExercise(exerciseToAdd);
          }
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
      width: double.infinity,
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
            height: AppLayout.defaultPadding,
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
                SizedBox(
                  height: AppLayout.miniPadding,
                ),
              ]
            );
          }),
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

Future<T?> _showExercisesBottomSheet<T>(
  BuildContext context,
  List<ExerciseDetailsEntity> exercises,
) {
  final _items = exercises;

  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    scrollControlDisabledMaxHeightRatio: 0.9,
    backgroundColor: context.colorScheme.backgroundSecondary,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ColoredBox(
                  color: context.colorScheme.backgroundSecondary,
                  child: ListView.separated(
                    itemCount: _items.length,
                    separatorBuilder: (context, index) => Divider(
                      color: context.colorScheme.divider,
                      height: 1,
                      indent: 64,
                    ),
                    itemBuilder: (context, index) {
                      final currentItem = _items[index];

                      return ExerciseListTile(
                        exercise: currentItem,
                        onTap: () {
                          Navigator.of(context).pop(currentItem);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
