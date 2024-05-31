import 'package:flex_workout_logger/features/workouts/domain/entities/workout.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/description.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/exercises.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/focus.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/icon.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/name.validation.dart';
import 'package:flex_workout_logger/features/workouts/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_edit.controller.g.dart';

///
@riverpod
class WorkoutEditController extends _$WorkoutEditController {
  @override
  FutureOr<WorkoutEntity> build(String id) async {
    final res = await ref.watch(workoutRepositoryProvider).getWorkoutById(id);

    return res.fold((l) => throw l, (r) => r);
  }

  ///
  Future<void> handle(
    WorkoutIcon icon,
    WorkoutName name,
    WorkoutFocus focus,
    WorkoutDescription? description,
    WorkoutExercises exercises,
  ) async {
    state = const AsyncLoading();

    final res = await ref.read(workoutRepositoryProvider).updateWorkout(
      id,
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
  }
}
