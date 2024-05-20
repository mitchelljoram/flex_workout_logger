import 'package:flex_workout_logger/features/workouts/domain/entities/exercise.entity.dart';
import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout.entity.freezed.dart';

/// Strongly Typed Model [WorkoutEntity]
@freezed
class WorkoutEntity with _$WorkoutEntity, Selectable, DatabaseEntity {
  /// [WorkoutEntity] factory constructor
  const factory WorkoutEntity({
    required String id,
    required String icon,
    required String name,
    required String focus,
    required String description,
    required int numberOfLifts,
    required int estimatedTime,
    @Default([]) List<ExerciseEntity> exercises,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkoutEntity;
}