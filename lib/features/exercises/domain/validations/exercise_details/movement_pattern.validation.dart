import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise details movement pattern value validation
class ExerciseDetailsMovementPattern extends Validation<MovementPatternEntity?> {
  ///
  factory ExerciseDetailsMovementPattern(MovementPatternEntity? input) {
    return ExerciseDetailsMovementPattern._(
      _validate(input),
    );
  }

  const ExerciseDetailsMovementPattern._(this._value);
  @override
  Either<Failure, MovementPatternEntity?> get value => _value;

  final Either<Failure, MovementPatternEntity?> _value;
}

Either<Failure, MovementPatternEntity?> _validate(
  MovementPatternEntity? input,
) {
  return right(input);
}
