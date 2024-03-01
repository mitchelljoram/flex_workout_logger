import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern/muscle_groups.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern/name.validation.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// MovementPattern Repository Interface
abstract class IMovementPatternRepository {
  /// Get MovementPattern list
  FutureOr<Either<Failure, List<MovementPatternEntity>>> getMovementPatterns();

  /// Get MovementPattern by id
  FutureOr<Either<Failure, MovementPatternEntity>> getMovementPatternById(
    String id,
  );

  /// Create MovementPattern
  FutureOr<Either<Failure, MovementPatternEntity>> createMovementPattern(
    MovementPatternIcon icon,
    MovementPatternName name,
    MovementPatternDescription description,
    MovementPatternMuscleGroups primaryMuscleGroups,
    MovementPatternMuscleGroups secondaryMuscleGroups,
  );

  /// Update MovementPattern
  FutureOr<Either<Failure, MovementPatternEntity>> updateMovementPattern(
    String? id,
    MovementPatternIcon? icon,
    MovementPatternName? name,
    MovementPatternDescription? description,
    MovementPatternMuscleGroups? primaryMuscleGroups,
    MovementPatternMuscleGroups? secondaryMuscleGroups,
  );

  /// Delete MovementPattern by id
  FutureOr<Either<Failure, bool>> deleteMovementPattern(String id);
}
