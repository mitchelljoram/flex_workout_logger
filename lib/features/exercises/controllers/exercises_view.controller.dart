import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_view.controller.g.dart';

/// Exercises view controller
@riverpod
class ExercisesViewController extends _$ExercisesViewController {
  @override
  FutureOr<ExerciseDetailsEntity> build(String id) async {
    final res = await ref.watch(exerciseDetailsRepositoryProvider).getExerciseById(id);
    return res.fold((l) => throw l, (r) => r);
  }
}
