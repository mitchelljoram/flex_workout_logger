import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/exercise_details.repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_weight.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/engagement.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/equipment.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/movement_pattern.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/muscle_groups.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/name.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/personal_record.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/type.validation.dart';
import 'package:flex_workout_logger/realm/schema.dart';
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
  FutureOr<Either<Failure, ExerciseDetailsEntity>> createExercise(
    ExerciseDetailsIcon icon,
    ExerciseDetailsBaseExercise? baseExercise,
    ExerciseDetailsName name,
    ExerciseDetailsDescription? description,
    // ExerciseDetailsMovementPattern? movementPattern,
    // ExerciseDetailsEquipment? equipment,
    // ExerciseDetailsEngagement engagement,
    // ExerciseDetailsType type,
    // ExerciseDetailsMuscleGroups primaryMuscleGroups,
    // ExerciseDetailsMuscleGroups secondaryMuscleGroups,
    // ExerciseDetailsBaseWeight baseWeight,
    // ExerciseDetailsPersonalRecord personalRecord,
  ) async {
    // TODO: implement createExercise
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteExercise(String id) async {
    // TODO: implement deleteExercise
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, int>> deleteMultipleExercises(List<String> ids) async {
    // TODO: implement deleteMultipleExercises
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, ExerciseDetailsEntity>> getExerciseById(String id) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<ExerciseDetails>(objectId);

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
  FutureOr<Either<Failure, List<ExerciseDetailsEntity>>> getExercises() async {
    try {
      final res = realm.all<ExerciseDetails>();

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
  FutureOr<Either<Failure, ExerciseDetailsEntity>> updateExercise(
    String? id,
    ExerciseDetailsIcon? icon,
    ExerciseDetailsBaseExercise? baseExercise,
    ExerciseDetailsName? name,
    ExerciseDetailsDescription? description,
    ExerciseDetailsMovementPattern? movementPattern,
    ExerciseDetailsEquipment? equipment,
    ExerciseDetailsEngagement? engagement,
    ExerciseDetailsType? type,
    ExerciseDetailsMuscleGroups? primaryMuscleGroups,
    ExerciseDetailsMuscleGroups? secondaryMuscleGroups,
    ExerciseDetailsBaseWeight? baseWeight,
    ExerciseDetailsPersonalRecord? personalRecord,
  ) async {
    // TODO: implement updateExercise
    throw UnimplementedError();
  }
}