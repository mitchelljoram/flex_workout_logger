import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/personal_record.entity.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_details.entity.freezed.dart';

/// Strongly Typed Model [ExerciseDetailsEntity]
@freezed
class ExerciseDetailsEntity with _$ExerciseDetailsEntity, Selectable, DatabaseEntity {
  /// [ExerciseDetailsEntity] factory constructor
  const factory ExerciseDetailsEntity({
    required String id,
    required String icon,
    ExerciseDetailsEntity? baseExercise,
    required String name,
    required String description,
    MovementPatternEntity? movementPattern,
    EquipmentEntity? equipment,
    required Engagement engagement,
    required ExerciseType type,
    @Default([]) List<MuscleGroupEntity> primaryMuscleGroups,
    @Default([]) List<MuscleGroupEntity> secondaryMuscleGroups,
    BaseWeightEntity? baseWeight,
    PersonalRecordEntity? personalRecord,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ExerciseDetailsEntity;
}
