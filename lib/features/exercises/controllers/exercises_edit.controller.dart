import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_weight.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/engagement.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/equipment.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/movement_pattern.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/muscle_groups.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/name.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/personal_record.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/type.validation.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_edit.controller.g.dart';

///
@riverpod
class ExercisesEditController extends _$ExercisesEditController {
  @override
  FutureOr<ExerciseDetailsEntity> build(String id) async {
    final res = await ref.watch(exerciseDetailsRepositoryProvider).getExerciseById(id);

    return res.fold((l) => throw l, (r) => r);
  }

  ///
  Future<void> handle(
    ExerciseDetailsIcon icon,
    ExerciseDetailsBaseExercise? baseExercise,
    ExerciseDetailsName name,
    ExerciseDetailsDescription description,
    ExerciseDetailsMovementPattern? movementPattern,
    ExerciseDetailsEquipment? equipment,
    ExerciseDetailsEngagement engagement,
    ExerciseDetailsType type,
    ExerciseDetailsMuscleGroups primaryMuscleGroups,
    ExerciseDetailsMuscleGroups secondaryMuscleGroups,
    ExerciseDetailsBaseWeight baseWeight,
    ExerciseDetailsPersonalRecord personalRecord,
  ) async {
    state = const AsyncLoading();

    final res = await ref.read(exerciseDetailsRepositoryProvider).updateExercise(
      id,
      icon,
      baseExercise,
      name,
      description,
      movementPattern,
      equipment,
      engagement,
      type,
      primaryMuscleGroups,
      secondaryMuscleGroups,
      baseWeight,
      personalRecord,
    );
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}
