import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

const MAX_NAME_LENGTH = 100;

/// Workout name value validation
class WorkoutName extends Validation<String> {
  ///
  factory WorkoutName(String input) {
    return WorkoutName._(
      _validate(input),
    );
  }

  const WorkoutName._(this._value);
  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if (input.isEmpty) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The workout must have a name.',
      ),
    );
  } else if (input.length > MAX_NAME_LENGTH) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The name must be less than $MAX_NAME_LENGTH characters.',
      ),
    );
  }

  return right(input);
}
