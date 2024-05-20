import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

abstract interface class Enumeration<T extends Enum> {
  late String name;
  String? description;
}

/// Engagement enum
enum Engagement implements Enumeration<Engagement> {
  /// Bilateral
  bilateral(
    name: 'Bilateral',
    description:
        'Exercises where both sides of the body work together For example a Squat or Bench Press.',
  ),

  /// Bilateral Seperate
  bilateralSeparate(
    name: 'Bilateral With Separate Weights',
    description:
        'Exercise where both sides of the body work together, but each side uses a separate weight. Ex: Dumbbell Bench Press',
  ),

  /// Unilateral
  unilateral(
    name: 'Unilateral',
    description:
        'Exercises where you work one side of the body at a time. Ex: Bulgarian Split Squat or Lunges',
  );

  const Engagement({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}

/// Exercise Type enum
enum ExerciseType implements Enumeration<ExerciseType> {
  /// Reps
  repitition(
    name: 'Reps',
  ),

  /// Timed
  timed(
    name: 'Timed',
  );

  // ignore: unused_element
  const ExerciseType({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}

/// Weight Unit enum
enum WeightUnits implements Enumeration<WeightUnits> {
  /// Kilograms
  kilograms(
    name: 'kgs',
  ),

  /// Pounds
  pounds(
    name: 'lbs',
  );

  // ignore: unused_element
  const WeightUnits({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}

/// Assisted Exercise enum
enum Assisted implements Enumeration<Assisted> {
  /// Not Assisted
  notAssisted(
    name: 'Not Assisted',
  ),

  /// Assisted
  assisted(
    name: 'Assisted',
  );

  // ignore: unused_element
  const Assisted({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}

/// Body Weight enum
enum BodyWeight implements Enumeration<BodyWeight> {
  /// Custom
  custom(
    name: 'Custom',
  ),

  /// Use Bodyweight
  useBodyweight(
    name: 'Use Bodyweight',
  );

  // ignore: unused_element
  const BodyWeight({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}

/// Set Type enum
enum SetType implements Enumeration<SetType> {
  /// Warmup
  warmup(
    name: 'Warmup',
  ),

  /// Technical
  technical(
    name: 'Technical',
  );

  // ignore: unused_element
  const SetType({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}

/// Rest Units enum
enum RestUnits implements Enumeration<RestUnits> {
  /// Seconds
  seconds(
    name: 'Seconds',
  ),

  /// Minutes
  minutes(
    name: 'Minutes',
  );

  // ignore: unused_element
  const RestUnits({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}

/// Rate of Percieved Exertion (RPE) enum
enum RPE implements Enumeration<RPE> {
  /// 1
  RPE1(
    name: '1',
  ),

  /// 10
  RPE10(
    name: '10',
  );

  // ignore: unused_element
  const RPE({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}


/// Reps in Reserve (RiR) enum
enum RiR implements Enumeration<RiR> {
  /// 1
  RiR1(
    name: '1',
  ),

  /// 10
  RiR10(
    name: '10',
  );

  // ignore: unused_element
  const RiR({required this.name, this.description});

  @override
  final String name;

  @override
  final String? description;

  @override
  set name(String name) => name;

  @override
  set description(String? description) => description;
}
