import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

const MIN_ENGAGEMENT_INDEX = 0;
const MAX_ENGAGEMENT_INDEX = 2;

/// Exercise details engagement value validation
class ExerciseDetailsEngagement extends Validation<Engagement> {
  ///
  factory ExerciseDetailsEngagement(Engagement input) {
    return ExerciseDetailsEngagement._(
      _validate(input),
    );
  }

  const ExerciseDetailsEngagement._(this._value);
  @override
  Either<Failure, Engagement> get value => _value;

  final Either<Failure, Engagement> _value;
}

Either<Failure, Engagement> _validate(Engagement input) {
  if (input.index.isNaN) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a type of engagment selected.',
      ),
    );
  }
  
  if (input.index < MIN_ENGAGEMENT_INDEX || input.index > MAX_ENGAGEMENT_INDEX) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have a valid type of engagment selected.',
      ),
    );
  }

  return right(input);
}
