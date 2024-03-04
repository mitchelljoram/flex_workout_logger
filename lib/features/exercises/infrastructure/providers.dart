import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/equipment.repository.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/exercise_details.repository.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/movement_pattern.repository.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/repositories/muscle_group.repository.dart';
import 'package:flex_workout_logger/realm/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

///
/// Infrastructure dependencies
///

/// Exercise deatils repository provider
@riverpod
ExerciseDetailsRepository exerciseDetailsRepository(
  ExerciseDetailsRepositoryRef ref
) {
  return ExerciseDetailsRepository(
    realm: ref.watch(realmClientProvider),
  );
}

/// Movement pattern repository provider
@riverpod
MovementPatternRepository movementPatternRepository(
  MovementPatternRepositoryRef ref,
) {
  return MovementPatternRepository(
    realm: ref.watch(realmClientProvider),
  );
}

/// Equipment repository providers
@riverpod
EquipmentRepository equipmentRepository(
  EquipmentRepositoryRef ref,
) {
  return EquipmentRepository(
    realm: ref.watch(realmClientProvider)
  );
}

/// Muscle group repository provider
@riverpod
MuscleGroupRepository muscleGroupRepository(MuscleGroupRepositoryRef ref) {
  return MuscleGroupRepository(
    realm: ref.watch(realmClientProvider),
  );
}