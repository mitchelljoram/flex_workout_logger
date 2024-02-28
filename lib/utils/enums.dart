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
        'Exercises where both sides of the body work together in unison, typically with a single resistance source. Ex: Squat',
  ),

  /// Bilateral Seperate
  bilateralSeparate(
    name: 'Bilateral With Separate Weights',
    description:
        'Exercise where both sides of the body also work together, but each side uses a separate weight. Ex: Dumbbell Bench Press',
  ),

  /// Unilateral
  unilateral(
    name: 'Unilateral',
    description:
        'Exercises focus on working one side of the body at a time, allowing each limb or side to work independently. Ex: Bulgarian Split Squat and Lunges',
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
