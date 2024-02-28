import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/personal_record.entity.dart';
import 'package:flex_workout_logger/utils/enums.dart';
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
  Engagement get engagement => Engagement.values[engagementAsInt];
  set engagement(Engagement value) => engagementAsInt = value.index;

  @MapTo('type')
  late int typeAsInt;
  ExerciseType get type => ExerciseType.values[typeAsInt];
  set type(ExerciseType value) => typeAsInt = value.index;

  late List<_MuscleGroup> primaryMuscleGroups;
  late List<_MuscleGroup> secondaryMuscleGroups;

  late _BaseWeight? baseWeight;

  late _PersonalRecord? personalRecord;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _ExerciseDetails extension
extension ConvertExerciseDetails on _ExerciseDetails {
  /// Convert [_Exercise] to [ExerciseDetailsEntity]
  ExerciseDetailsEntity toEntity() {
    return ExerciseDetailsEntity(
      id: id.hexString, 
      icon: icon, 
      baseExercise: baseExercise?.toEntity(),
      name: name, 
      description: description, 
      movementPattern: movementPattern?.toEntity(),
      equipment: equipment?.toEntity(),
      engagement: engagement, 
      type: type, 
      primaryMuscleGroups:
          primaryMuscleGroups.map((e) => e.toEntity()).toList(),
      secondaryMuscleGroups:
          secondaryMuscleGroups.map((e) => e.toEntity()).toList(),
      baseWeight: baseWeight?.toEntity(),
      personalRecord: personalRecord?.toEntity(),
      createdAt: createdAt, 
      updatedAt: updatedAt,
    );
  }
}

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

/// _MovementPattern extension
extension ConvertMovementPattern on _MovementPattern {
  /// Convert [_MovementPattern] to [MovementPatternEntity]
  MovementPatternEntity toEntity() {
    return MovementPatternEntity(
      id: id.hexString, 
      icon: icon, 
      name: name, 
      description: description, 
      primaryMuscleGroups:
          primaryMuscleGroups.map((e) => e.toEntity()).toList(),
      secondaryMuscleGroups:
          secondaryMuscleGroups.map((e) => e.toEntity()).toList(),
      createdAt: createdAt, 
      updatedAt: updatedAt
    );
  }
}

@RealmModel()
class _Equipment {
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late String name;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _Equipment extension
extension ConvertEquipment on _Equipment {
  /// Convert [_Equipment] to [EquipmentEntity]
  EquipmentEntity toEntity() {
    return EquipmentEntity(
      id: id.hexString, 
      icon: icon, 
      name: name,
      createdAt: createdAt, 
      updatedAt: updatedAt
    );
  }
}

@RealmModel()
class _MuscleGroup {
  @PrimaryKey()
  late ObjectId id;

  late String icon;

  late String name;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _MuscleGroup extension
extension ConvertMuscleGroup on _MuscleGroup {
  /// Convert [_Equipment] to [MuscleGroupEntity]
  MuscleGroupEntity toEntity() {
    return MuscleGroupEntity(
      id: id.hexString, 
      icon: icon, 
      name: name,
      createdAt: createdAt, 
      updatedAt: updatedAt
    );
  }
}

@RealmModel(ObjectType.embeddedObject)
class _BaseWeight {
  late double weightKgs;
  late double weightLbs;

  late bool assisted;
  late bool bodyWeight;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _BaseWeight extension
extension ConvertBaseWeight on _BaseWeight {
  /// Convert [_BaseWeight] to [BaseWeightEntity]
  BaseWeightEntity toEntity() {
    return BaseWeightEntity(
      weightKgs: weightKgs,
      weightLbs: weightLbs,
      assisted: assisted,
      bodyWeight: bodyWeight,
      createdAt: createdAt, 
      updatedAt: updatedAt
    );
  }
}

@RealmModel(ObjectType.embeddedObject)
class _PersonalRecord {
  @MapTo('type')
  late int typeAsInt;
  ExerciseType get type => ExerciseType.values[typeAsInt];
  set type(ExerciseType value) => typeAsInt = value.index;

  late double oneRepMaxEstimate;
  late double tenRepMaxEstimate;
  late double maxWeight;

  late int bestTime;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _PersonalRecord extension
extension ConvertPersonalRecord on _PersonalRecord {
  /// Convert [_PersonalRecord] to [PersonalRecordEntity]
  PersonalRecordEntity toEntity() {
    return PersonalRecordEntity(
      type: type,
      oneRepMaxEstimate: oneRepMaxEstimate,
      tenRepMaxEstimate: tenRepMaxEstimate,
      maxWeight: maxWeight,
      bestTime: bestTime,
      createdAt: createdAt, 
      updatedAt: updatedAt
    );
  }
}


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

/// _Workout extension
/// TODO: Add WorkoutEntity converter

@RealmModel(ObjectType.embeddedObject)
class _Exercise{
  late _ExerciseDetails? exercise;

  late List<_Set> warmupSets;
  late List<_Set> workingSets;

  late String notes;

  late List<_ExerciseDetails> alternatives;

  late DateTime createdAt;
  late DateTime updatedAt;  
}

/// _Exercise extension
/// TODO: Add ExerciseEntity converter

@RealmModel(ObjectType.embeddedObject)
class _Set{
  @MapTo('type')
  late int typeAsInt;
  // SetType get type => SetType.values[typeAsInt];
  // set type(SetType value) => typeAsInt = value.index;

  late int minNumberReps;
  late int maxNumberReps;

  late double minRestTime;
  late double maxRestTime;

  @MapTo('restUnit')
  late int restUnitAsInt;
  // RestUnits get restUnit => RestUnits.values[restUnitAsInt];
  // set restUnit(RestUnits value) => restUnitAsInt = value.index;

  late double minIntensity;
  late double maxIntensity;

  @MapTo('exertion')
  late int exertionAsInt;
  // RPE get exertion => RPE.values[exertionAsInt];
  // set exertion(RPE value) => exertionAsInt = value.index;
  /// TODO: RiR?

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _Set extension
/// TODO: Add SetEntity converter


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

/// _Program extension
/// TODO: Add ProgramEntity converter

@RealmModel(ObjectType.embeddedObject)
class _Phase{
  late String name;

  late List<_Week> weeks;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// TODO: Add PhaseEntity converter

@RealmModel(ObjectType.embeddedObject)
class _Week{
  late int week;

  late int repititions;

  late List<_Workout> workouts;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _Week extension
/// TODO: Add WeekEntity converter


/// History

@RealmModel()
class _History{
  @PrimaryKey()
  late ObjectId id;

  late DateTime archiveDate;

  late _Workout? workout;

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _History extension
/// TODO: Add HistoryEntity converter


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

/// _LiveWorkout extension
/// TODO: Add LiveWorkoutEntity converter

@RealmModel(ObjectType.embeddedObject)
class _LiveExercise{
  late _ExerciseDetails? exercise;

  late List<_LiveSet> warmupSets;
  late List<_LiveSet> workingSets;

  late String notes;

  late bool skipped;

  late List<_ExerciseDetails> alternatives;

  late DateTime createdAt;
  late DateTime updatedAt; 
}

/// _LiveExercise extension
/// TODO: Add LiveExerciseEntity converter

@RealmModel(ObjectType.embeddedObject)
class _LiveSet{
  @MapTo('type')
  late int typeAsInt;
  // SetType get type => SetType.values[typeAsInt];
  // set type(SetType value) => typeAsInt = value.index;

  late _Set? target;

  late double weight;

  @MapTo('unit')
  late int unitAsInt;
  // WeightUnits get unit => WeightUnits.values[unitAsInt];
  // set unit(WeightUnits value) => unitAsInt = value.index;

  late int reps;

  @MapTo('exertion')
  late int exertionAsInt;
  // RPE get exertion => RPE.values[exertionAsInt];
  // set exertion(RPE value) => exertionAsInt = value.index;
  /// TODO: RiR?

  late DateTime createdAt;
  late DateTime updatedAt;
}

/// _LiveSet extension
/// TODO: Add LiveSetEntity converter
