import 'package:realm/realm.dart';

part 'schema.g.dart';

/// Exercises

@RealmModel()
class _ExerciseDetails {
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late _ExerciseDetails? baseExercise;

  late String name;
  late String description;

  late _MovementPattern? movementPattern;

  late _Equipment? equipment;

  @MapTo('engagement')
  late int engagementAsInt;
  // EngagementEnum get engagement => EngagementEnum.values[engagementAsInt];
  // set engagement(EngagementEnum value) => engagementAsInt = value.index;

  @MapTo('type')
  late int typeAsInt;
  // TypeEnum get type => TypeEnum.values[typeAsInt];
  // set type(TypeEnum value) => typeAsInt = value.index;

  late List<_MuscleGroup> primaryMuscleGroups;
  late List<_MuscleGroup> secondaryMuscleGroups;

  late _BaseWeight baseWeight;

  // TODO: personal records?

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add ExerciseDetailsEntity converter

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
  late double weight;

  @MapTo('units')
  late int unitAsInt;
  // UnitsEnum get unit => UnitsEnum.values[unitAsInt];
  // set unit(UnitsEnum value) => unitAsInt = value.index;

  late bool assisted;
  late bool bodyWeight;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add BaseWeightEntity converter


/// Workouts

@RealmModel()
class _Workout {
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late String name;
  late String description;
  late String focus;

  late int numberOfLifts;
  late int estimatedTime;

  late List<_Exercise> exercises;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add WorkoutEntity converter

@RealmModel()
class _Exercise{
  late _ExerciseDetails exercise;

  late List<_Set> warmupSets;
  late List<_Set> workingSets;

  late String notes;

  late List<_ExerciseDetails> alternatives;

  late DateTime createdAt;
  late DateTime updatedAt;  
}

// TODO: Add ExerciseEntity converter

@RealmModel()
class _Set{
  @MapTo('sets')
  late int setAsInt;
  // SetEnum get setType => SetEnum.values[setAsInt];
  // set setType(SetEnum value) => setAsInt = value.index;

  late int minNumberReps;
  late int maxNumberReps;

  late double minRestTime;
  late double maxRestTime;

  @MapTo('restUnits')
  late int restUnitAsInt;
  // RestUnitsEnum get restUnit => RestUnitsEnum.values[restUnitAsInt];
  // set restUnit(RestUnitsEnum value) => restUnitAsInt = value.index;
}

// TODO: Add SetEntity converter

/// Routines




/// History




/// Workout Tracker

