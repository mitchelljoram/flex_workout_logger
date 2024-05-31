import 'package:flex_workout_logger/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'set.entity.freezed.dart';

/// Strongly Typed Model [SetEntity]
@freezed
class SetEntity with _$SetEntity {
  /// [SetEntity] factory constructor
  const factory SetEntity({
    required SetType type,
    required int minNumberReps,
    required int maxNumberReps,
    required double time,
    required double minRestTime,
    required double maxRestTime,
    required RestUnits restUnits,
    required double minIntensity,
    required double maxIntensity,
    required RPE exertionRPE,
    required RiR exertionRiR,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SetEntity;
}