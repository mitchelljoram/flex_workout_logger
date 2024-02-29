import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
/// TODO: import validations
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
    // MovementPatternIcon icon,
    // MovementPatternName name,
    // MovementPatternDescription? description,
    // MovementPatternMuscleGroups primaryMuscleGroups,
    // MovementPatternMuscleGroups secondaryMuscleGroups,
  );

  /// Update MovementPattern
  FutureOr<Either<Failure, MovementPatternEntity>> updateMovementPattern(
    String? id,
    // MovementPatternIcon icon,
    // MovementPatternName name,
    // MovementPatternDescription? description,
    // MovementPatternMuscleGroups primaryMuscleGroups,
    // MovementPatternMuscleGroups secondaryMuscleGroups,
  );

  /// Delete MovementPattern by id
  FutureOr<Either<Failure, bool>> deleteMovementPattern(String id);
}
