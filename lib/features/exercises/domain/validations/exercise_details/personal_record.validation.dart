import 'package:flex_workout_logger/features/exercises/domain/entities/personal_record.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/validation_abstract.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/fpdart.dart';

/// Exercise details personal record value validation
class ExerciseDetailsPersonalRecord extends Validation<PersonalRecordEntity?> {
  ///
  factory ExerciseDetailsPersonalRecord(PersonalRecordEntity? input) {
    return ExerciseDetailsPersonalRecord._(
      _validate(input),
    );
  }

  const ExerciseDetailsPersonalRecord._(this._value);
  @override
  Either<Failure, PersonalRecordEntity?> get value => _value;

  final Either<Failure, PersonalRecordEntity?> _value;
}

Either<Failure, PersonalRecordEntity?> _validate(
  PersonalRecordEntity? input,
) {
  return right(input);
}
