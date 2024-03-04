import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/muscle_group.repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/muscle_group/name.validation.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/src/either.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for muscle groups
class MuscleGroupRepository implements IMuscleGroupRepository {
  /// Constructor
  MuscleGroupRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, MuscleGroupEntity>> createMuscleGroup(
    MuscleGroupIcon icon,
    MuscleGroupName name,
  ) {
    /// TODO: implement createMuscleGroup
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteMuscleGroup(String id) {
    /// TODO: implement deleteMuscleGroup
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, MuscleGroupEntity>> getMuscleGroupById(String id) {
    /// TODO: implement getMuscleGroupById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<MuscleGroupEntity>>> getMuscleGroups() {
    /// TODO: implement getMuscleGroups
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, MuscleGroupEntity>> updateMuscleGroup(
    String? id,
    MuscleGroupIcon? icon,
    MuscleGroupName? name,
  ) {
    /// TODO: implement updateMuscleGroup
    throw UnimplementedError();
  }
}