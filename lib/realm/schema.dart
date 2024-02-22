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

  @MapTo('unit')
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
  late int typeAsInt;
  // SetEnum get type => SetEnum.values[typeAsInt];
  // set type(SetEnum value) => typeAsInt = value.index;

  late int minNumberReps;
  late int maxNumberReps;

  late double minRestTime;
  late double maxRestTime;

  @MapTo('restUnit')
  late int restUnitAsInt;
  // RestUnitsEnum get restUnit => RestUnitsEnum.values[restUnitAsInt];
  // set restUnit(RestUnitsEnum value) => restUnitAsInt = value.index;

  late double minIntensity;
  late double maxIntensity;

  @MapTo('exertion')
  late int exertionAsInt;
  // RPEEnum get exertion => RPEEnum.values[exertionAsInt];
  // set exertion(RPEEnum value) => exertionAsInt = value.index;
  // TODO: RiREnum?

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add SetEntity converter

/// Programs

@RealmModel()
class _Program{
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late String name;
  late String description;
  late String focus;

  late int numberOfWeeks;
  late int numberOfPhases;

  late int minDaysPerWeek;
  late int maxDaysPerWeek;

  late List<_Phase> phases;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add ProgramEntity converter

@RealmModel()
class _Phase{
  late String name;

  late List<_Week> weeks;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add PhaseEntity converter

@RealmModel()
class _Week{
  late int week;

  late int repititions;

  late List<_Workout> workouts;

  late DateTime createdAt;
  late DateTime updatedAt;
}

// TODO: Add WeekEntity converter

/// History

@RealmModel()
class _History{
  @PrimaryKey()
  late ObjectId id;

  late DateTime archiveDate;

  late _Workout workout;

  late DateTime createdAt;
  late DateTime updatedAt;
}


/// Workout Tracker

@RealmModel()
class _LiveWorkout{
  @PrimaryKey()
  late ObjectId id;

  late String name;

  late int setsCompleted;
  late int repsCompleted;

  late double totalVolumeMoved;

  late DateTime startTime;

  late int durationInSecs;

  late double completionPercent;

  late List<_LiveExercise> exercises;

  late DateTime createdAt;
  late DateTime updatedAt;
}

@RealmModel()
class _LiveExercise{
  late _ExerciseDetails exercise;

  late List<_LiveSet> warmupSets;
  late List<_LiveSet> workingSets;

  late String notes;

  late bool skipped;

  late List<_ExerciseDetails> alternatives;

  late DateTime createdAt;
  late DateTime updatedAt; 
}

@RealmModel()
class _LiveSet{
  @MapTo('type')
  late int typeAsInt;
  // SetEnum get type => SetEnum.values[typeAsInt];
  // set type(SetEnum value) => typeAsInt = value.index;

  late _Set target;

  late double weight;

  @MapTo('unit')
  late int unitAsInt;
  // UnitsEnum get unit => UnitsEnum.values[unitAsInt];
  // set unit(UnitsEnum value) => unitAsInt = value.index;

  late int reps;

  @MapTo('exertion')
  late int exertionAsInt;
  // RPEEnum get exertion => RPEEnum.values[exertionAsInt];
  // set exertion(RPEEnum value) => exertionAsInt = value.index;
  // TODO: RiREnum?

  late DateTime createdAt;
  late DateTime updatedAt;
}