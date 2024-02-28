import 'package:flex_workout_logger/utils/interfaces.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipment.entity.freezed.dart';

/// Strongly Typed Model [EquipmentEntity]
@freezed
class EquipmentEntity with _$EquipmentEntity, Selectable, DatabaseEntity {
  /// [EquipmentEntity] factory constructor
  const factory EquipmentEntity({
    required String id,
    required String icon,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EquipmentEntity;
}
