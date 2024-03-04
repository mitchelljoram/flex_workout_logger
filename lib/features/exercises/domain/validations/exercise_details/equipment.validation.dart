import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise details equipment value validation
class ExerciseDetailsEquipment extends Validation<EquipmentEntity?> {
  ///
  factory ExerciseDetailsEquipment(EquipmentEntity? input) {
    return ExerciseDetailsEquipment._(
      _validate(input),
    );
  }

  const ExerciseDetailsEquipment._(this._value);
  @override
  Either<Failure, EquipmentEntity?> get value => _value;

  final Either<Failure, EquipmentEntity?> _value;
}

Either<Failure, EquipmentEntity?> _validate(
  EquipmentEntity? input,
) {
  return right(input);
}
