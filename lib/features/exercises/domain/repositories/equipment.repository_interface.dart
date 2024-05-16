import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/equipment/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/equipment/name.validation.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Equipment Repository Interface
abstract class IEquipmentRepository {
  /// Get Equipment list
  FutureOr<Either<Failure, List<EquipmentEntity>>> getEquipment();

  /// Get Equipment by id
  FutureOr<Either<Failure, EquipmentEntity>> getEquipmentById(
    String id,
  );

  /// Create Equipment
  FutureOr<Either<Failure, EquipmentEntity>> createEquipment(
    EquipmentIcon icon,
    EquipmentName name,
  );

  /// Update Equipment
  FutureOr<Either<Failure, EquipmentEntity>> updateEquipment(
    String? id,
    EquipmentIcon? icon,
    EquipmentName? name,
  );

  /// Delete Equipment by id
  FutureOr<Either<Failure, bool>> deleteEquipment(String id);
}
