import 'dart:async';

import 'package:flex_workout_logger/features/workouts/domain/entities/workout.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/description.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/exercises.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/focus.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/icon.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/name.validation.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Workout Repository Interface
abstract class IWorkoutRepository {
  /// Get Workout list
  FutureOr<Either<Failure, List<WorkoutEntity>>> getWorkouts();

  /// Get Workout by id
  FutureOr<Either<Failure, WorkoutEntity>> getWorkoutById(String id);

  /// Create Workout
  FutureOr<Either<Failure, WorkoutEntity>> createWorkout(
    WorkoutIcon icon,
    WorkoutName name,
    WorkoutFocus focus,
    WorkoutDescription? description,
    WorkoutExercises exercises,
  );

  /// Update Workout
  FutureOr<Either<Failure, WorkoutEntity>> updateWorkout(
    String id,
    WorkoutIcon icon,
    WorkoutName name,
    WorkoutFocus focus,
    WorkoutDescription? description,
    WorkoutExercises exercises,
  );

  /// Delete Workout by id
  FutureOr<Either<Failure, bool>> deleteWorkout(String id);

  /// Delete many Workouts by id
  FutureOr<Either<Failure, int>> deleteMultipleWorkouts(List<String> ids);
}