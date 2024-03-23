
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/name.validation.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_create.controller.g.dart';

///
@riverpod
class ExercisesCreateController extends _$ExercisesCreateController {
  @override
  FutureOr<ExerciseDetailsEntity?> build() {
    return null;
  }

  ///
  Future<void> handle(
    ExerciseDetailsIcon icon,
    ExerciseDetailsBaseExercise? baseExercise,
    ExerciseDetailsName name,
    ExerciseDetailsDescription? description,
  ) async {
    state = const AsyncLoading();

    // final primaryMuscleGroups = ExerciseDetailsMuscleGroups(muscleGroups.value.getOrElse((l) => EMPTY_MUSCLE_GROUPS_MAP).entries.firstWhere((entry) => entry.key == MuscleGroupPriority.primary).value);
    // final secondaryMuscleGroups = ExerciseDetailsMuscleGroups(muscleGroups.value.getOrElse((l) => EMPTY_MUSCLE_GROUPS_MAP).entries.firstWhere((entry) => entry.key == MuscleGroupPriority.secondary).value);

    final res = await ref.read(exerciseDetailsRepositoryProvider).createExercise(
      icon,
      baseExercise,
      name,
      description,
    );
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}
