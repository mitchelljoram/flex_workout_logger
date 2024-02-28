import 'package:flex_workout_logger/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_record.entity.freezed.dart';

/// Strongly PersonalRecordd Model [PersonalRecordEntity]
@freezed
class PersonalRecordEntity with _$PersonalRecordEntity {
  /// [PersonalRecordEntity] factory constructor
  const factory PersonalRecordEntity({
    ExerciseType? type,
    @Default(0.0) double oneRepMaxEstimate,
    @Default(0.0) double tenRepMaxEstimate,
    @Default(0.0) double maxWeight,
    @Default(0) int bestTime,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PersonalRecordEntity;
}
