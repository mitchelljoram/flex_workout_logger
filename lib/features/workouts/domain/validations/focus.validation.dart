import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

const MAX_FOCUS_LENGTH = 100;

/// Workout focus value validation
class WorkoutFocus extends Validation<String> {
  ///
  factory WorkoutFocus(String input) {
    return WorkoutFocus._(
      _validate(input),
    );
  }

  const WorkoutFocus._(this._value);
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
  } else if (input.length > MAX_FOCUS_LENGTH) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The name must be less than $MAX_FOCUS_LENGTH characters.',
      ),
    );
  }

  return right(input);
}
