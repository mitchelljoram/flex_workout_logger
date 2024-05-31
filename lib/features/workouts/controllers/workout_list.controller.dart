import 'package:flex_workout_logger/features/workouts/domain/entities/workout.entity.dart';
import 'package:flex_workout_logger/features/workouts/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_list.controller.g.dart';

/// Controller for the exercises list
@riverpod
class WorkoutListController extends _$WorkoutListController {
  @override
  FutureOr<List<WorkoutEntity>> build() async {
    final res = await ref.watch(workoutRepositoryProvider).getWorkouts();
    return res.fold((l) => throw l, (r) => r);
  }

  /// Add an entity to list
  void addWorkout(WorkoutEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.add(entity);
    state = AsyncValue.data(items);
  }

  /// Update an entity in the list
  void editWorkout(WorkoutEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    final i = items.indexWhere((element) => element.id == entity.id);
    if (i != -1) {
      items
        ..removeAt(i)
        ..insert(i, entity);
    }

    state = AsyncValue.data(items);
  }

  /// Delete an entity in the list
  void deleteWorkout(WorkoutEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.remove(entity);
    state = AsyncValue.data(items);
  }
}
