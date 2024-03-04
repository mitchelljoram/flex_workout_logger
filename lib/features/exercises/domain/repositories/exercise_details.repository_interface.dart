import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
/// TODO: import validations
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
    // ExerciseIcon icon,
    // ExerciseBaseExercise? baseExercise,
    // ExerciseName name,
    // ExerciseDescription description,
    // ExerciseMovementPattern? movementPattern,
    // ExerciseEquipment equipment,
    // ExerciseEngagement engagement,
    // ExerciseType type,
    // ExerciseMuscleGroups primaryMuscleGroups,
    // ExerciseMuscleGroups secondaryMuscleGroups,
    // ExerciseBaseWeight baseWeight,
    // ExercisePersonalRecord personalRecord,
  );

  /// Update Exercise
  FutureOr<Either<Failure, ExerciseDetailsEntity>> updateExercise(
    // String id,
    // ExerciseIcon icon,
    // ExerciseBaseExercise? baseExercise,
    // ExerciseName name,
    // ExerciseDescription description,
    // ExerciseMovementPattern? movementPattern,
    // ExerciseEquipment equipment,
    // ExerciseEngagement engagement,
    // ExerciseType type,
    // ExerciseMuscleGroups primaryMuscleGroups,
    // ExerciseMuscleGroups secondaryMuscleGroups,
    // ExerciseBaseWeight baseWeight,
    // ExercisePersonalRecord personalRecord,
  );

  /// Delete Exercise by id
  FutureOr<Either<Failure, bool>> deleteExercise(String id);

  /// Delete many Exercises by id
  FutureOr<Either<Failure, int>> deleteMultipleExercises(List<String> ids);
}
