import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/movement_pattern.repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern/muscle_groups.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/movement_pattern/name.validation.dart';
import 'package:flex_workout_logger/realm/schema.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/src/either.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for movement patterns
class MovementPatternRepository implements IMovementPatternRepository {
  /// Constructor
  MovementPatternRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> createMovementPattern(
    MovementPatternIcon icon,
    MovementPatternName name,
    MovementPatternDescription description,
    MovementPatternMuscleGroups primaryMuscleGroups,
    MovementPatternMuscleGroups secondaryMuscleGroups,
  ) async {
    // TODO: implement createMovementPattern
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteMovementPattern(String id) async {
    // TODO: implement deleteMovementPattern
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> getMovementPatternById(String id) async {
    // TODO: implement getMovementPatternById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<MovementPatternEntity>>> getMovementPatterns() async {
    try {
      final res = realm.all<MovementPattern>();

      return right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> updateMovementPattern(
    String? id,
    MovementPatternIcon? icon,
    MovementPatternName? name,
    MovementPatternDescription? description,
    MovementPatternMuscleGroups? primaryMuscleGroups,
    MovementPatternMuscleGroups? secondaryMuscleGroups,
  ) async {
    // TODO: implement updateMovementPattern
    throw UnimplementedError();
  }
}