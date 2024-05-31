import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

const MAX_DESCRIPTION_LENGTH = 1500;

/// Workout description value validation
class WorkoutDescription extends Validation<String> {
  ///
  factory WorkoutDescription(String input) {
    return WorkoutDescription._(
      _validate(input),
    );
  }

  const WorkoutDescription._(this._value);
  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if (input.length > MAX_DESCRIPTION_LENGTH) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The description must be less than $MAX_DESCRIPTION_LENGTH characters.',
      ),
    );
  }

  return right(input);
}
