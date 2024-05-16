import 'dart:async';

import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/repositories/muscle_group.repository_interface.dart';
import 'package:flex_workout_logger/realm/schema.dart';
import 'package:flex_workout_logger/utils/failure.dart';
import 'package:fpdart/src/either.dart';
import 'package:realm/realm.dart';

/// Fully implemented repository for muscle groups
class MuscleGroupRepository implements IMuscleGroupRepository {
  /// Constructor
  MuscleGroupRepository({required this.realm});

  /// Realm instance
  final Realm realm;

  @override
  FutureOr<Either<Failure, MuscleGroupEntity>> getMuscleGroupById(String id) async {
    /// TODO: implement getMuscleGroupById
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<Failure, List<MuscleGroupEntity>>> getMuscleGroups() async {
    try {
      final res = realm.all<MuscleGroup>();

      return right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(
        Failure.internalServerError(
          message: e.toString(),
        ),
      );
    }
  }
}