import 'package:flex_workout_logger/features/exercises/controllers/exercises_edit.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_weight.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/engagement.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/equipment.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/movement_pattern.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/muscle_groups.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/name.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/personal_record.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/type.validation.dart';
import 'package:flex_workout_logger/features/exercises/ui/containers/exercise_details_flow.dart';
import 'package:flex_workout_logger/ui/widgets/app_error.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail Edit Screen
class ExerciseEditScreen extends ConsumerWidget {
  /// Constructor
  const ExerciseEditScreen({required this.id, super.key});

  /// Exercise id
  final String id;

  /// Route name
  static const routeName = 'exercises_edit';

  /// Path name where eid is the id of the exercise
  static const routePath = 'exercises/:eid/edit';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercise = ref.watch(exercisesEditControllerProvider(id));

    return Scaffold(
      backgroundColor: context.colorScheme.backgroundSecondary,
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: context.colorScheme.backgroundSecondary,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(
            CupertinoIcons.xmark,
          ),
          color: context.colorScheme.foregroundPrimary,
          iconSize: 24,
        ),
        middle: Text(
          'Edit Exercise',
          style: TextStyle(color: context.colorScheme.foregroundPrimary),
        ),
      ),
      body: exercise.when(
        data: (data) => ExerciseDetailsFlow(
          initialExerciseDetails: ExerciseDetails(
            id: id,
            icon: ExerciseDetailsIcon(data.icon),
            baseExercise: ExerciseDetailsBaseExercise(null,data.baseExercise),
            name: ExerciseDetailsName(data.name),
            description: ExerciseDetailsDescription(data.description),
            movementPattern: ExerciseDetailsMovementPattern(data.movementPattern),
            equipment: ExerciseDetailsEquipment(data.equipment),
            engagement: ExerciseDetailsEngagement(data.engagement),
            type: ExerciseDetailsType(data.type),
            primaryMuscleGroups: ExerciseDetailsMuscleGroups(data.primaryMuscleGroups),
            secondaryMuscleGroups: ExerciseDetailsMuscleGroups(data.secondaryMuscleGroups),
            baseWeight: ExerciseDetailsBaseWeight(data.baseWeight),
            personalRecord: ExerciseDetailsPersonalRecord(
              data.personalRecord
            ),
          ),
        ), 
        error: (o, e) => AppError(
          title: o.toString(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}