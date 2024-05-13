// ignore_for_file: use_raw_strings

import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/personal_record.entity.dart';
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
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:flex_workout_logger/utils/infrastructure.dart';
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
    ExerciseDetailsMovementPattern? movementPattern,
    ExerciseDetailsEquipment? equipment,
    ExerciseDetailsEngagement engagement,
    ExerciseDetailsType type,
    ExerciseDetailsMuscleGroups primaryMuscleGroups,
    ExerciseDetailsMuscleGroups secondaryMuscleGroups,
    ExerciseDetailsBaseWeight baseWeight,
    ExerciseDetailsPersonalRecord personalRecord,
  ) async {
    try {
      final currentDateTime = DateTimeX.current;
      final icon_ = icon.value.getOrElse((l) => '');
      final baseExercise_ = getRealmObjectFromEntity<ExerciseDetailsEntity, ExerciseDetails>(
        realm,
        baseExercise?.value.getOrElse((l) => null),
      );
      final name_ = name.value.getOrElse((l) => 'No name provided');
      final description_ = description?.value.getOrElse((l) => '');
      final movementPattern_ = getRealmObjectFromEntity<MovementPatternEntity, MovementPattern>(
        realm,
        movementPattern?.value.getOrElse((l) => null),
      );
      final equipment_ = getRealmObjectFromEntity<EquipmentEntity, Equipment>(
        realm,
        equipment?.value.getOrElse((l) => null),
      );;
      final engagement_ = engagement.value.getOrElse((l) => Engagement.bilateral);
      final type_ = type.value.getOrElse((l) => ExerciseType.repitition);
      final primaryMuscleGroups_ = getRealmResultsFromEntityList<MuscleGroupEntity, MuscleGroup>(
        realm,
        primaryMuscleGroups.value.getOrElse((l) => []),
      );
      final secondaryMuscleGroups_ = getRealmResultsFromEntityList<MuscleGroupEntity, MuscleGroup>(
        realm,
        secondaryMuscleGroups.value.getOrElse((l) => []),
      );

      final _baseWeight = baseWeight.value.getOrElse((l) => BaseWeightEntity(
        assisted: false,
        bodyWeight: false,
        createdAt: DateTimeX.current,
        updatedAt: DateTimeX.current,
      ));
      final baseWeight_ = BaseWeight(
        _baseWeight!.weightKgs != 0.0 ? _baseWeight.weightKgs : double.parse((_baseWeight.weightLbs / 2.205).toStringAsFixed(2)),
        _baseWeight.weightLbs != 0.0 ? _baseWeight.weightLbs : double.parse((_baseWeight.weightKgs * 2.205).toStringAsFixed(2)), 
        _baseWeight.assisted, 
        _baseWeight.bodyWeight, 
        _baseWeight.createdAt, 
        _baseWeight.updatedAt
      );

      final _personalRecord = personalRecord.value.getOrElse((l) => PersonalRecordEntity(
        createdAt: DateTimeX.current,
        updatedAt: DateTimeX.current,
      ));
      final personalRecord_ = PersonalRecord(
        _personalRecord!.oneRepMaxEstimateKgs != 0.0 ? _personalRecord.oneRepMaxEstimateKgs : double.parse((_personalRecord.oneRepMaxEstimateLbs / 2.205).toStringAsFixed(2)),
        _personalRecord.oneRepMaxEstimateLbs != 0.0 ? _personalRecord.oneRepMaxEstimateLbs : double.parse((_personalRecord.oneRepMaxEstimateKgs * 2.205).toStringAsFixed(2)),
        _personalRecord.tenRepMaxEstimateKgs != 0.0 ? _personalRecord.tenRepMaxEstimateKgs : double.parse((_personalRecord.tenRepMaxEstimateLbs / 2.205).toStringAsFixed(2)), 
        _personalRecord.tenRepMaxEstimateLbs != 0.0 ? _personalRecord.oneRepMaxEstimateLbs : double.parse((_personalRecord.oneRepMaxEstimateKgs * 2.205).toStringAsFixed(2)), 
        _personalRecord.maxWeightKgs, 
        _personalRecord.maxWeightLbs, 
        _personalRecord.bestTime, 
        _personalRecord.createdAt, 
        _personalRecord.updatedAt
      );

      final exerciseToAdd = ExerciseDetails(
        ObjectId(),
        icon_,
        name_,
        description_ ?? '',
        engagement_.index,
        type_.index,
        currentDateTime,
        currentDateTime,
      )
        ..baseExercise = baseExercise_
        ..movementPattern = movementPattern_
        ..equipment = equipment_
        ..baseWeight = baseWeight_
        ..personalRecord = personalRecord_;

      final res = realm.write<ExerciseDetails>(() {
        // Add muscle groups to exercise
        exerciseToAdd.primaryMuscleGroups.addAll(primaryMuscleGroups_);
        exerciseToAdd.secondaryMuscleGroups.addAll(secondaryMuscleGroups_);

        return realm.add(exerciseToAdd);
      });

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
  FutureOr<Either<Failure, bool>> deleteExercise(String id) async {
    try {
      final objectId = ObjectId.fromHexString(id);

      final res = realm.find<ExerciseDetails>(objectId);

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