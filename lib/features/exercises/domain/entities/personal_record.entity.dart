import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_record.entity.freezed.dart';

/// Strongly Typed Model [PersonalRecordEntity]
@freezed
class PersonalRecordEntity with _$PersonalRecordEntity {
  /// [PersonalRecordEntity] factory constructor
  const factory PersonalRecordEntity({
    @Default(0.0) double oneRepMaxEstimateKgs,
    @Default(0.0) double oneRepMaxEstimateLbs,
    @Default(0.0) double tenRepMaxEstimateKgs,
    @Default(0.0) double tenRepMaxEstimateLbs,
    @Default(0.0) double maxWeightKgs,
    @Default(0.0) double maxWeightLbs,
    @Default(0) int bestTime,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PersonalRecordEntity;
}
