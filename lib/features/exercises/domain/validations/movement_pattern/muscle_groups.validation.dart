import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

const MAX_MUSCLE_GROUPS_LENGTH = 5;

/// Movement pattern muscle groups value validation
class MovementPatternMuscleGroups extends Validation<List<MuscleGroupEntity>> {
  ///
  factory MovementPatternMuscleGroups(List<MuscleGroupEntity> input) {
    return MovementPatternMuscleGroups._(
      _validate(input),
    );
  }

  const MovementPatternMuscleGroups._(this._value);
  @override
  Either<Failure, List<MuscleGroupEntity>> get value => _value;

  final Either<Failure, List<MuscleGroupEntity>> _value;
}

Either<Failure, List<MuscleGroupEntity>> _validate(
  List<MuscleGroupEntity> input,
) {
  if (input.length > MAX_MUSCLE_GROUPS_LENGTH) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The movement pattern must have no more than $MAX_MUSCLE_GROUPS_LENGTH muscle groups.',
      ),
    );
  }

  return right(input);
}
