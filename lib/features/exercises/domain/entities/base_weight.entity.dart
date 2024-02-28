import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_weight.entity.freezed.dart';

/// Strongly Typed Model [BaseWeightEntity]
@freezed
class BaseWeightEntity with _$BaseWeightEntity {
  /// [BaseWeightEntity] factory constructor
  const factory BaseWeightEntity({
    @Default(0.0) double weightKgs,
    @Default(0.0) double weightLbs,
    required bool assisted,
    required bool bodyWeight,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BaseWeightEntity;
}
