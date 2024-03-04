import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise details base exercise value validation
class ExerciseDetailsBaseExercise extends Validation<ExerciseDetailsEntity?> {
  ///
  factory ExerciseDetailsBaseExercise(
    String? currentExerciseId,
    ExerciseDetailsEntity? baseExercise,
  ) {
    return ExerciseDetailsBaseExercise._(
      _validate(currentExerciseId, baseExercise),
    );
  }

  const ExerciseDetailsBaseExercise._(this._value);
  @override
  Either<Failure, ExerciseDetailsEntity?> get value => _value;

  final Either<Failure, ExerciseDetailsEntity?> _value;
}

Either<Failure, ExerciseDetailsEntity?> _validate(
  String? currentExerciseId,
  ExerciseDetailsEntity? baseExercise,
) {
  if (baseExercise == null) {
    return right(null);
  }

  if (baseExercise.baseExercise != null) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The base exercise can not be a variation.',
      ),
    );
  }

  if (currentExerciseId == baseExercise.id) {
    return left(
      const Failure.unprocessableEntity(
        message: 'The base exercise can not be the same as the parent exercise.',
      ),
    );
  }

  return right(baseExercise);
}
