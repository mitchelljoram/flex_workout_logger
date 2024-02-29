import 'dart:async';


import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
/// TODO: import validations
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// MuscleGroup Repository Interface
abstract class IMuscleGroupRepository {
  /// Get MuscleGroup list
  FutureOr<Either<Failure, List<MuscleGroupEntity>>> getMuscleGroups();

  /// Get MuscleGroup by id
  FutureOr<Either<Failure, MuscleGroupEntity>> getMuscleGroupById(
    String id,
  );

  /// Create MuscleGroup
  FutureOr<Either<Failure, MuscleGroupEntity>> createMuscleGroup(
    // MuscleGroupIcon icon,
    // MuscleGroupName name,
  );

  /// Update MuscleGroup
  FutureOr<Either<Failure, MuscleGroupEntity>> updateMuscleGroup(
    String? id,
    // MuscleGroupIcon? icon,
    // MuscleGroupName? name,
  );

  /// Delete MuscleGroup by id
  FutureOr<Either<Failure, bool>> deleteMuscleGroup(String id);
}
