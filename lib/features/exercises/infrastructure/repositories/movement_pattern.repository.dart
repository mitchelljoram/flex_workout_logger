import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/movement_pattern.repository_interface.dart';
/// TODO: import validations
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
  FutureOr<Either<Failure, MovementPatternEntity>> createMovementPattern() {
    // TODO: implement createMovementPattern
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteMovementPattern(String id) {
    // TODO: implement deleteMovementPattern
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> getMovementPatternById(String id) {
    // TODO: implement getMovementPatternById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<MovementPatternEntity>>> getMovementPatterns() {
    // TODO: implement getMovementPatterns
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, MovementPatternEntity>> updateMovementPattern(String? id) {
    // TODO: implement updateMovementPattern
    throw UnimplementedError();
  }
}