import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/exercise_details.repository_interface.dart';
/// TODO: import validations
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/src/either.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for exercise details
class ExerciseDetailsRepository implements IExerciseDetailsRepository {
  /// Constructor
  ExerciseDetailsRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, ExerciseDetailsEntity>> createExercise() {
    // TODO: implement createExercise
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteExercise(String id) {
    // TODO: implement deleteExercise
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, int>> deleteMultipleExercises(List<String> ids) {
    // TODO: implement deleteMultipleExercises
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, ExerciseDetailsEntity>> getExerciseById(String id) {
    // TODO: implement getExerciseById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<ExerciseDetailsEntity>>> getExercises() {
    // TODO: implement getExercises
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, ExerciseDetailsEntity>> updateExercise() {
    // TODO: implement updateExercise
    throw UnimplementedError();
  }
}