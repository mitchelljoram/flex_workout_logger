// ignore_for_file: use_raw_strings

import 'dart:async';

import 'package:flex_workout_logger/features/workouts/domain/entities/workout.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/repositories/workout.repository_interface.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/description.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/exercises.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/focus.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/icon.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/name.validation.dart';
import 'package:flex_workout_logger/realm/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/infrastructure.dart';
import 'package:fpdart/src/either.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for exercise details
class WorkoutRepository implements IWorkoutRepository {
  /// Constructor
  WorkoutRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, WorkoutEntity>> createWorkout(
    WorkoutIcon icon,
    WorkoutName name,
    WorkoutFocus focus,
    WorkoutDescription? description,
    WorkoutExercises exercises,
  ) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, bool>> deleteWorkout(String id) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<Workout>(objectId);

      if (res == null) {
        return left(const Failure.empty());
      }

      realm.write(() {
        realm.delete(res);
      });

      return right(true);
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        )
      );
    }
  }

  @override
  FutureOr<Either<Failure, int>> deleteMultipleWorkouts(List<String> ids) async {
    // TODO: implement deleteMultipleWorkouts
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, WorkoutEntity>> getWorkoutById(String id) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<Workout>(objectId);

      if (res == null) {
        return left(const Failure.empty());
      }

      return right(res.toEntity());
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  FutureOr<Either<Failure, List<WorkoutEntity>>> getWorkouts() async {
    try {
      final res = realm.all<Workout>();

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
  FutureOr<Either<Failure, WorkoutEntity>> updateWorkout(
    String id,
    WorkoutIcon icon,
    WorkoutName name,
    WorkoutFocus focus,
    WorkoutDescription? description,
    WorkoutExercises exercises,
  ) async {
    try {
      throw UnimplementedError();
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }
}