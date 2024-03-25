import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_card.dart';
import 'package:flex_workout_logger/ui/widgets/entity_selection_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseBaseExerciseController extends ConsumerWidget {
  final FormFieldValidator? validator;
  final void Function(ExerciseDetailsEntity) onChanged;
  final ExerciseDetailsEntity? initialValue;

  const ChooseBaseExerciseController({
    required this.validator,
    required this.onChanged,
    required this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variationExercises = ref
        .read(exercisesListControllerProvider.notifier)
        .getBaseExerciseList();

    return EntitySelectionSheet<ExerciseDetailsEntity>(
      validator: validator,
      hintText: 'Select a base exercise',
      labelText: 'Base Exercise',
      onChanged: onChanged,
      initialValue: initialValue,
      isRequired: true,
      items: variationExercises.asData?.value
        .map(
          (be) => DropdownMenuItem(
            value: be,
            child: ExerciseListTile(
              exercise: be,
              trailingIcon: CupertinoIcons.add_circled,
              onTap: () {
                Navigator.of(context).pop(be);
              },
            ),
          ),
        )
        .toList() ??
      [],
    );
  }
}