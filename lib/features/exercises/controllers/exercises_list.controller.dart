import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_list.controller.g.dart';

/// Controller for the exercises list
@riverpod
class ExercisesListController extends _$ExercisesListController {
  @override
  FutureOr<List<ExerciseDetailsEntity>> build() async {
    final res = await ref.watch(exerciseDetailsRepositoryProvider).getExercises();
    return res.fold((l) => throw l, (r) => r);
  }

  /// Filters the list to only get items that are not the base exercise
  /// or are not a variation
  AsyncValue<List<ExerciseDetailsEntity>> getBaseExerciseList({
    String? baseExerciseId,
  }) {
    final items = state.valueOrNull ?? [];

    final filteredList = items
        .where(
          (element) =>
              element.id != baseExerciseId && element.baseExercise == null,
        )
        .toList();

    return AsyncValue.data(filteredList);
  }

  /// Add an entity to list
  void addExercise(ExerciseDetailsEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.add(entity);
    state = AsyncValue.data(items);
  }

  /// Update an entity in the list
  void editExercise(ExerciseDetailsEntity entity) {
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
  void deleteExercise(ExerciseDetailsEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.remove(entity);
    state = AsyncValue.data(items);
  }
}
