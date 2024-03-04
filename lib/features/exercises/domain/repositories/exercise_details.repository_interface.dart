import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
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
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise Repository Interface
abstract class IExerciseDetailsRepository {
  /// Get Exercise list
  FutureOr<Either<Failure, List<ExerciseDetailsEntity>>> getExercises();

  /// Get Exercise by id
  FutureOr<Either<Failure, ExerciseDetailsEntity>> getExerciseById(String id);

  /// Create Exercise
  FutureOr<Either<Failure, ExerciseDetailsEntity>> createExercise(
    ExerciseDetailsIcon icon,
    ExerciseDetailsBaseExercise? baseExercise,
    ExerciseDetailsName name,
    ExerciseDetailsDescription description,
    ExerciseDetailsMovementPattern? movementPattern,
    ExerciseDetailsEquipment? equipment,
    ExerciseDetailsEngagement engagement,
    ExerciseDetailsType type,
    ExerciseDetailsMuscleGroups primaryMuscleGroups,
    ExerciseDetailsMuscleGroups secondaryMuscleGroups,
    ExerciseDetailsBaseWeight baseWeight,
    ExerciseDetailsPersonalRecord personalRecord,
  );

  /// Update Exercise
  FutureOr<Either<Failure, ExerciseDetailsEntity>> updateExercise(
    String? id,
    ExerciseDetailsIcon? icon,
    ExerciseDetailsBaseExercise? baseExercise,
    ExerciseDetailsName? name,
    ExerciseDetailsDescription? description,
    ExerciseDetailsMovementPattern? movementPattern,
    ExerciseDetailsEquipment? equipment,
    ExerciseDetailsEngagement? engagement,
    ExerciseDetailsType? type,
    ExerciseDetailsMuscleGroups? primaryMuscleGroups,
    ExerciseDetailsMuscleGroups? secondaryMuscleGroups,
    ExerciseDetailsBaseWeight? baseWeight,
    ExerciseDetailsPersonalRecord? personalRecord,
  );

  /// Delete Exercise by id
  FutureOr<Either<Failure, bool>> deleteExercise(String id);

  /// Delete many Exercises by id
  FutureOr<Either<Failure, int>> deleteMultipleExercises(List<String> ids);
}
