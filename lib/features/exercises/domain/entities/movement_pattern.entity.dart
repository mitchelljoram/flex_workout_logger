import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movement_pattern.entity.freezed.dart';

/// Strongly Typed Model [MovementPatternEntity]
@freezed
class MovementPatternEntity
    with _$MovementPatternEntity, Selectable, DatabaseEntity {
  /// [MovementPatternEntity] factory constructor
  const factory MovementPatternEntity({
    required String id,
    required String icon,
    required String name,
    required String description,
    @Default([]) List<MuscleGroupEntity> primaryMuscleGroups,
    @Default([]) List<MuscleGroupEntity> secondaryMuscleGroups,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<String>? exerciseIds,
  }) = _MovementPatternEntity;
}
