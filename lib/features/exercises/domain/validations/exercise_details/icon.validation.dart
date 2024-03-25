import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'dart:io';

/// Exercise details icon value validation
class ExerciseDetailsIcon extends Validation<String> {
  ///
  factory ExerciseDetailsIcon(String input) {
    return ExerciseDetailsIcon._(
      _validate(input),
    );
  }

  const ExerciseDetailsIcon._(this._value);
  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if(input.isEmpty) {
    return right(input);
  }

  if (File('assets/icons/$input/').existsSync() == false) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The icon must exist.',
      ),
    );
  }

  return right(input);
}
