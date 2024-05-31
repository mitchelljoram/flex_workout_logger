import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/exercise.entity.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

const MAX_MUSCLE_GROUPS_LENGTH = 25;

/// Exercise details muscle groups value validation
class WorkoutExercises extends Validation<List<ExerciseEntity>> {
  ///
  factory WorkoutExercises(List<ExerciseEntity> input) {
    return WorkoutExercises._(
      _validate(input),
    );
  }

  const WorkoutExercises._(this._value);
  @override
  Either<Failure, List<ExerciseEntity>> get value => _value;

  final Either<Failure, List<ExerciseEntity>> _value;
}

Either<Failure, List<ExerciseEntity>> _validate(
  List<ExerciseEntity> input,
) {
  if (input.length > MAX_MUSCLE_GROUPS_LENGTH) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The exercise must have no more than $MAX_MUSCLE_GROUPS_LENGTH exercises.',
      ),
    );
  }

  return right(input);
}
