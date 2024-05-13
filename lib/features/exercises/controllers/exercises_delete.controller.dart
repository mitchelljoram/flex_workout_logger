import 'package:flex_workout_logger/features/exercises/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_delete.controller.g.dart';

///
@riverpod
class ExercisesDeleteController extends _$ExercisesDeleteController {
  @override
  FutureOr<bool> build(String id) {
    return false;
  }

  ///
  Future<void> handle() async {
    final res = await ref.read(exerciseDetailsRepositoryProvider).deleteExercise(id);
    state = res.fold(
      (l) => AsyncValue.error(l.error, StackTrace.current),
      AsyncValue.data,
    );
  }
}
