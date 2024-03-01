import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

const MAX_MUSCLE_GROUPS_LENGTH = 5;

/// Exercise details muscle groups value validation
class ExerciseDetailsMuscleGroups extends Validation<List<MuscleGroupEntity>> {
  ///
  factory ExerciseDetailsMuscleGroups(List<MuscleGroupEntity> input) {
    return ExerciseDetailsMuscleGroups._(
      _validate(input),
    );
  }

  const ExerciseDetailsMuscleGroups._(this._value);
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
        message: 'The exercise must have no more than $MAX_MUSCLE_GROUPS_LENGTH muscle groups.',
      ),
    );
  }

  return right(input);
}
