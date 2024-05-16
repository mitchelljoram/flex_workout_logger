
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'muscle_group_list.controller.g.dart';

/// Controller for the movement pattern list
@riverpod
class MuscleGroupListController extends _$MuscleGroupListController {
  @override
  FutureOr<List<MuscleGroupEntity>> build() async {
    final res = await ref
        .watch(muscleGroupRepositoryProvider)
        .getMuscleGroups();
    return res.fold((l) => throw l, (r) => r);
  }
}
