import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/personal_record.entity.dart';
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
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail Create Screen
class WorkoutCreateScreen extends StatelessWidget {
  /// Constructor
  const WorkoutCreateScreen({super.key});

  /// Route name
  static const routeName = 'workout_create';

  /// Path name where eid is the id of the exercise
  static const routePath = 'workout/create';

  @override
  Widget build(BuildContext context) {
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
          'Create Workout',
          style: TextStyle(color: context.colorScheme.foregroundPrimary),
        ),
      ),
      body: ExerciseDetailsFlow(
        initialExerciseDetails: ExerciseDetails(
          id: null,
          icon: ExerciseDetailsIcon(''),
          baseExercise: ExerciseDetailsBaseExercise(null,null),
          name: ExerciseDetailsName(''),
          description: ExerciseDetailsDescription(''),
          movementPattern: ExerciseDetailsMovementPattern(null),
          equipment: ExerciseDetailsEquipment(null),
          engagement: ExerciseDetailsEngagement(Engagement.bilateral),
          type: ExerciseDetailsType(ExerciseType.repitition),
          primaryMuscleGroups: ExerciseDetailsMuscleGroups([]),
          secondaryMuscleGroups: ExerciseDetailsMuscleGroups([]),
          baseWeight: ExerciseDetailsBaseWeight(
            BaseWeightEntity(
              weightKgs: 0.0,
              weightLbs: 0.0,
              assisted: false,
              bodyWeight: false,
              createdAt: DateTimeX.current,
              updatedAt: DateTimeX.current
            )
          ),
          personalRecord: ExerciseDetailsPersonalRecord(
            PersonalRecordEntity(
              oneRepMaxEstimateKgs: 0.0,
              oneRepMaxEstimateLbs: 0.0,
              tenRepMaxEstimateKgs: 0.0,
              tenRepMaxEstimateLbs: 0.0,
              maxWeightKgs: 0.0,
              maxWeightLbs: 0.0,
              bestTime: 0,
              createdAt: DateTimeX.current,
              updatedAt: DateTimeX.current
            )
          ),
        ),
      )
    );
  }
}
