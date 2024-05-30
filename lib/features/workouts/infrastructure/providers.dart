import 'package:flex_workout_logger/realm/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

///
/// Infrastructure dependencies
///

/// Workout repository provider
@riverpod
WorkoutRepository workoutRepository(
  WorkoutRepositoryRef ref
) {
  return WorkoutRepository(
    realm: ref.watch(realmClientProvider),
  );
}