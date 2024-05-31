import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/set.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.entity.freezed.dart';

/// Strongly Typed Model [ExerciseEntity]
@freezed
class ExerciseEntity with _$ExerciseEntity {
  /// [ExerciseEntity] factory constructor
  const factory ExerciseEntity({
    required ExerciseDetailsEntity? exercise,
    @Default([]) List<SetEntity> warmupSets,
    @Default([]) List<SetEntity> workingSets,
    required String notes,
    @Default([]) List<ExerciseDetailsEntity> alternatives,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ExerciseEntity;
}