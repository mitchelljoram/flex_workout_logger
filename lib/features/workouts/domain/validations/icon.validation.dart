import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'dart:io';

/// Workout icon value validation
class WorkoutIcon extends Validation<String> {
  ///
  factory WorkoutIcon(String input) {
    return WorkoutIcon._(
      _validate(input),
    );
  }

  const WorkoutIcon._(this._value);
  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if(input.isEmpty) {
    return right(input);
  }

  if (File('assets/icons/exercises/$input').exists() == false) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The icon must exist.',
      ),
    );
  }

  return right(input);
}
