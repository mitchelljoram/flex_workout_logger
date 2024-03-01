import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise details movement pattern value validation
class ExerciseDetailsBaseWeight extends Validation<BaseWeightEntity?> {
  ///
  factory ExerciseDetailsBaseWeight(BaseWeightEntity? input) {
    return ExerciseDetailsBaseWeight._(
      _validate(input),
    );
  }

  const ExerciseDetailsBaseWeight._(this._value);
  @override
  Either<Failure, BaseWeightEntity?> get value => _value;

  final Either<Failure, BaseWeightEntity?> _value;
}

Either<Failure, BaseWeightEntity?> _validate(
  BaseWeightEntity? input,
) {
  return right(input);
}
