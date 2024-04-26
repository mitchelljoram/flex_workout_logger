import 'dart:math';

import 'package:flex_workout_logger/realm/schema.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:realm/realm.dart';

/// Seeds the realm with data on first load
void realmSeed(Realm realm) {
  final initialExerciseNames = <String>[
    'Bench Press',
    'Squat',
    'Deadlift',
    'Overhead Press',
    'Barbell Row',
    'Pull Up',
    'Chin Up',
    'Dip',
    'Push Up',
    'Sit Up',
    'Crunch',
    'Plank',
    'Lunge',
    'Calf Raise',
    'Leg Press',
    'Leg Curl',
    'Leg Extension',
    'Leg Raise',
  ];

  final initialMovementPatternNames = <String>[
    'Squat',
    'Hip Hinge',
    'Vertical Pull',
    'Vertical Push',
    'Horizontal Pull',
    'Horizontal Push',
    'Hip Extension',
    'Pull Over',
    'Fly',
    'Isolation',
    'Carrying',
    'Jumping',
    'Mobility',
  ];

  final initialEquipmentNames = <String>[
    'Treadmill',
    'Stationary Bike',
    'Elliptical Trainer',
    'Rowing Machine',
    'Smith Machine',
    'Barbell',
    'Dumbbells',
    'Kettlebells',
    'Medicine Ball',
    'Stability Ball',
    'Resistance Bands',
    'Cable Machine',
    'Leg Press Machine',
    'Lat Pulldown Machine',
    'Pull-up Bar',
    'Battle Ropes',
    'Jump Rope',
    'Bench Press',
    'Fly Machine',
    'Power Rack',
  ];

  final initialMuscleGroupNames = <String>[
    'Quads',
    'Glutes',
    'Hamstrings',
    'Erectors',
    'Lats',
    'Biceps',
    'Shoulders',
    'Triceps',
    'Retractors',
    'Chest',
    'Calves',
    'Abs',
    'Forearms',
    'Neck',
    'Groin',
  ];

  late final initialMovementPatterns = initialMovementPatternNames.map(
    (e) => MovementPattern(
      ObjectId(),
      'movement.100x100.png',
      e,
      '',
      DateTimeX.current,
      DateTimeX.current,
    ),
  );

  late final initialEquipment = initialEquipmentNames.map(
    (e) => Equipment(
      ObjectId(), 
      'equipment.100x100.png', 
      e, 
      DateTimeX.current,
      DateTimeX.current,
    ),
  );

  late final initialMuscleGroups = initialMuscleGroupNames.map(
    (e) => MuscleGroup(
      ObjectId(),
      'muscle.100x100.png',
      e,
      DateTimeX.current,
      DateTimeX.current,
    ),
  );

  realm
    ..addAll(initialMovementPatterns)
    ..addAll(initialEquipment)
    ..addAll(initialMuscleGroups);

  RealmResults<MovementPattern> movementPatterns = realm.all<MovementPattern>();
  RealmResults<Equipment> equipment = realm.all<Equipment>();
  Random r = new Random();

  late final initialExercisesDetails = initialExerciseNames.map(
    (e) => ExerciseDetails(
      ObjectId(),
      'exercise.primary.100x100.png',
      e,
      '',
      1,
      0,
      DateTimeX.current,
      DateTimeX.current,
      baseExercise: null,
      movementPattern: movementPatterns[r.nextInt(movementPatterns.length)],
      equipment: equipment[r.nextInt(equipment.length)],
      baseWeight: BaseWeight(100, 202.5, false, false, DateTimeX.current, DateTimeX.current),
      personalRecord: PersonalRecord(100, 202.5, 100, 202.5, 100, 202.5, 0, DateTimeX.current, DateTimeX.current),
      primaryMuscleGroups: const [],
      secondaryMuscleGroups: const [],
    ),
  );

  realm
    ..addAll(initialExercisesDetails);
}
