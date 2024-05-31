import 'package:flex_workout_logger/features/workouts/domain/entities/workout.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/description.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/exercises.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/focus.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/icon.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/name.validation.dart';
import 'package:flex_workout_logger/features/workouts/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_create.controller.g.dart';

///
@riverpod
class WorkoutCreateController extends _$WorkoutCreateController {
  @override
  FutureOr<WorkoutEntity?> build() {
    return null;
  }

  ///
  Future<String?> handle(
    WorkoutIcon icon,
    WorkoutName name,
    WorkoutFocus focus,
    WorkoutDescription? description,
    WorkoutExercises exercises,
  ) async {
    state = const AsyncLoading();

    final res = await ref.read(workoutRepositoryProvider).createWorkout(
      icon,
      name,
      focus,
      description,
      exercises,
    );
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );

    if (state.hasValue && !state.hasError) {
      return state.value!.id;
    }

    return null;
  }
}
