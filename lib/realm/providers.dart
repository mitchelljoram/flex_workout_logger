import 'package:flex_workout_logger/realm/schema.dart';
import 'package:flex_workout_logger/realm/seed.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

/// Realm providers

/// Exposes [Realm] instance
@riverpod
Future<Realm> realm(RealmRef ref) async {
  final config = Configuration.local(
    [
      /// Exercises
      ExerciseDetails.schema, MovementPattern.schema, Equipment.schema, MuscleGroup.schema, BaseWeight.schema, PersonalRecord.schema,
      /// Workouts
      Workout.schema, Exercise.schema, Set.schema, 
      /// Programs
      Program.schema, Phase.schema, Week.schema, 
      /// History
      History.schema, 
      /// Workout Tracker
      LiveWorkout.schema, LiveExercise.schema, LiveSet.schema, 
    ],
    initialDataCallback: realmSeed,
  );
  return Realm(config);
}

/// Exposes [Realm] for the client
@riverpod
Realm realmClient(RealmClientRef ref) {
  return ref.watch(realmProvider).value!;
}

/// Triggered from the boostrap to ensure the futures are complete
Future<void> initializeProviders(ProviderContainer container) async {
  /// Core
  await container.read(realmProvider.future);
}
