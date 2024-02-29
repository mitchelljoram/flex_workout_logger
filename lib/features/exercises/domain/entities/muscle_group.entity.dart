import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'muscle_group.entity.freezed.dart';

/// Strongly Typed Model [MuscleGroupEntity]
@freezed
class MuscleGroupEntity with _$MuscleGroupEntity, Selectable, DatabaseEntity {
  /// [MuscleGroupEntity] factory constructor
  const factory MuscleGroupEntity({
    required String id,
    required String icon,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MuscleGroupEntity;
}
