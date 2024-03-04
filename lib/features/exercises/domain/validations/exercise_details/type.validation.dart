import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

const MIN_TYPE_INDEX = 0;
const MAX_TYPE_INDEX = 1;

/// Exercise details tpye value validation
class ExerciseDetailsType extends Validation<ExerciseType> {
  ///
  factory ExerciseDetailsType(ExerciseType input) {
    return ExerciseDetailsType._(
      _validate(input),
    );
  }

  const ExerciseDetailsType._(this._value);
  @override
  Either<Failure, ExerciseType> get value => _value;

  final Either<Failure, ExerciseType> _value;
}

Either<Failure, ExerciseType> _validate(ExerciseType input) {
  if (input.index.isNaN) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a type of style selected',
      ),
    );
  }
  
  if (input.index < MIN_TYPE_INDEX || input.index > MAX_TYPE_INDEX) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a valid type of style selected',
      ),
    );
  }

  return right(input);
}
