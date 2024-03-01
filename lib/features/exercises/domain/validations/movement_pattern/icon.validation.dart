import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'dart:io';

/// Movement pattern icon value validation
class MovementPatternIcon extends Validation<String> {
  ///
  factory MovementPatternIcon(String input) {
    return MovementPatternIcon._(
      _validate(input),
    );
  }

  const MovementPatternIcon._(this._value);
  @override
  Either<Failure, String> get value => _value;

  final Either<Failure, String> _value;
}

Either<Failure, String> _validate(String input) {
  if (File('assets/icons/$input/').existsSync() == false) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The icon must exist.',
      ),
    );
  }

  return right(input);
}
