import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/exercise.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/set.entity.dart';
import 'package:flex_workout_logger/ui/widgets/bubbles.dart';
import 'package:flex_workout_logger/ui/widgets/entity_list_tiles.dart';
import 'package:flex_workout_logger/ui/widgets/enum_dropdown_menu.dart';
import 'package:flex_workout_logger/ui/widgets/flexable_textfield.dart';
import 'package:flex_workout_logger/ui/widgets/textfield_dropdown_input.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
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
                exerciseName: e.exercise!.name,
                exerciseType: e.exercise!.type,
                initialSets: e.warmupSets,
                isWarmup: true,
              ),
              SizedBox(
                height: AppLayout.smallPadding,
              ),
              SetsCard(
                label: 'Working',
                exerciseName: e.exercise!.name,
                exerciseType: e.exercise!.type,
                initialSets: e.workingSets,
                isWarmup: false,
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
    required this.exerciseName,
    required this.exerciseType,
    required this.initialSets,
    required this.isWarmup,
    super.key,
  });

  final String label;

  final String exerciseName;

  final ExerciseType exerciseType;

  final List<SetEntity> initialSets;

  final bool isWarmup;

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
            onTap: () {
              var res = _showSetBottomSheet(
                context, 
                widget.isWarmup ? 'Warmup Set ${_sets.length + 1}' : 'Set ${_sets.length + 1}', 
                widget.exerciseName, 
                widget.exerciseType, 
                widget.isWarmup, 
                null, 
                0, 
                0, 
                0, 
                0, 
                0, 
                0, 
                0, 
                RestUnits.minutes
              );
            }
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
    builder: (context) => Column(
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
  );
}

Future<T?> _showSetBottomSheet<T>(
  BuildContext context,
  String label,
  String exerciseName,
  ExerciseType exerciseType,
  bool isWarmup,
  SetType? initialType,
  int initialMinReps,
  int initialMaxReps,
  double initialTime,
  double? initialMinIntensity,
  double? initialMaxIntensity,
  double? initialMinRest,
  double? initialMaxRest,
  RestUnits? initialRestUnits,
) {
  SetType? _type = isWarmup ? SetType.warmup : initialType;
  int _minReps = exerciseType == ExerciseType.repitition ? initialMinReps : 0;
  int _maxReps = exerciseType == ExerciseType.repitition ? initialMaxReps : 0;
  double _time = exerciseType == ExerciseType.timed ? initialTime : 0;
  double _minIntensity = initialMinIntensity ?? 0.0;
  double _maxIntensity = initialMaxIntensity ?? 0.0;
  double _minRest = initialMinRest ?? 0.0;
  double _maxRest = initialMaxRest ?? 0.0;
  RestUnits _restUnits = RestUnits.minutes;

  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: false,
    scrollControlDisabledMaxHeightRatio: 0.9,
    backgroundColor: context.colorScheme.backgroundSecondary,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.all(AppLayout.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => context.colorScheme.backgroundTertiary,
                  ),
                ),
                color: context.colorScheme.foregroundPrimary,
                onPressed: () {
                  Navigator.of(context).pop(null);
                }, 
                icon: Icon(
                  CupertinoIcons.xmark,
                  size: 24,
                )
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    label,
                    style: context.textTheme.labelLarge.copyWith(
                      color: context.colorScheme.foregroundPrimary,
                    ),
                  ),
                  Text(
                    exerciseName,
                    style: context.textTheme.labelSmall.copyWith(
                      color: context.colorScheme.foregroundSecondary,
                    ),
                  )
                ],
              ),
              Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => context.colorScheme.foregroundPrimary,
                  ),
                ),
                color: context.colorScheme.backgroundPrimary,
                onPressed: () {
                  Navigator.of(context).pop(null);
                }, 
                icon: Icon(
                  CupertinoIcons.check_mark,
                  size: 24,
                )
              ),
            ],
          ),
          SizedBox(
            height: AppLayout.defaultPadding,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Type of set',
                style: context.textTheme.labelMedium.copyWith(
                  color: context.colorScheme.foregroundPrimary,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              EnumDropdownMenu( 
                hintText: 'Select a type of set', 
                width: MediaQuery.sizeOf(context).width - (AppLayout.defaultPadding * 2), 
                dropdownEntries: isWarmup ? [SetType.warmup] : [SetType.normal, SetType.technical, SetType.dropset, SetType.ipartials, SetType.llpartials, SetType.mdropset, SetType.myoreps],
                initalEntry: _type,
                onChanged: (value) {},
                isDisabled: isWarmup,
              ),
            ],
          ),
          SizedBox(
            height: AppLayout.defaultPadding,
          ),
          FlexableTextField( // TODO: create reps input widget
            label: 'Number of reps',
            hintText: '8-10',
            errorText: null,
            onChanged: (value) {
              var reps = value.split('-');
              _minReps = int.parse(reps[0].trim());
              _maxReps = reps.length > 1 ? int.parse(reps[1].trim()) : _minReps;
            },
            validator: (value) => null, // TODO: add reps validation
            controller: null, // TODO: add reps controller
            readOnly: false,
            isRequired: true,
          ),
          SizedBox(
            height: AppLayout.defaultPadding,
          ),
          TextfieldDropdownInput(
            label: 'Intensity', 
            textfieldHintText: '85-87.5', 
            dropdownHintText: 'Select an RPE',
            dropdownEntries: RPE.values, 
            validator: (value) {}, // TODO: add intensity validation
            onChanged: (value, unit) {}, // TODO: add intensity on changed
            readOnly: false
          ),
          SizedBox(
            height: AppLayout.defaultPadding,
          ),
          TextfieldDropdownInput(
            label: 'Rest Duration', 
            textfieldHintText: '3-5', 
            dropdownHintText: 'Select a time unit',
            dropdownEntries: RestUnits.values, 
            validator: (value) {}, // TODO: add rest duration validation
            onChanged: (value, unit) {}, // TODO: add rest duration on changed
            readOnly: false
          ),
        ],
      ),
    )
  );
}
