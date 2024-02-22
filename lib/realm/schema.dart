import 'package:realm/realm.dart';

part 'schema.g.dart';

/// Exercises

@RealmModel()
class _Exercise {
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late _Exercise? baseExercise;

  late String name;
  late String description;

  late _MovementPattern? movementPattern;

  late _Equipment? equipment;

  @MapTo('engagement')
  late int engagementAsInt;
  // Engagement get engagement => Engagement.values[engagementAsInt];
  // set engagement(Engagement value) => engagementAsInt = value.index;

  @MapTo('type')
  late int typeAsInt;
  // Type get type => Type.values[typeAsInt];
  // set type(Type value) => typeAsInt = value.index;

  late List<_MuscleGroup> primaryMuscleGroups;
  late List<_MuscleGroup> secondaryMuscleGroups;

  late _BaseWeight baseWeight;

  // TODO: personal records?

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add ExerciseEntity converter

@RealmModel()
class _MovementPattern {
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late String name;
  late String description;

  late List<_MuscleGroup> primaryMuscleGroups;
  late List<_MuscleGroup> secondaryMuscleGroups;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add MovementPatternEntity converter

@RealmModel()
class _Equipment {
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late String name;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add EquipmentEntity converter

@RealmModel()
class _MuscleGroup {
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late String name;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add MuscleGroupEntity converter

@RealmModel()
class _BaseWeight {
  @PrimaryKey()
  late ObjectId id;

  late double weight;

  @MapTo('units')
  late int unitAsInt;
  // Unit get unit => Unit.values[unitAsInt];
  // set unit(Unit value) => unitAsInt = value.index;

  late bool assisted;
  late bool bodyWeight;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add BaseWeightEntity converter


/// Workouts




/// Routines




/// History




/// Workout Tracker

