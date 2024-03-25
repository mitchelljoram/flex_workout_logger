import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/equipment.repository_interface.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/equipment/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/equipment/name.validation.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/src/either.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for equipment
class EquipmentRepository implements IEquipmentRepository {
  /// Constructor
  EquipmentRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, EquipmentEntity>> createEquipment(
    EquipmentIcon icon,
    EquipmentName name,
  ) {
    // TODO: implement createEquipment
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, bool>> deleteEquipment(String id) {
    // TODO: implement deleteEquipment
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, EquipmentEntity>> getEquipmentById(String id) {
    // TODO: implement getEquipmentById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<EquipmentEntity>>> getEquipment() {
    // TODO: implement getEquipments
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, EquipmentEntity>> updateEquipment(
    String? id,
    EquipmentIcon? icon,
    EquipmentName? name,
  ) {
    // TODO: implement updateEquipment
    throw UnimplementedError();
  }
}