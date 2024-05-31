import 'package:flex_workout_logger/features/workouts/ui/containers/workout_flow.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail Create Screen
class WorkoutCreateScreen extends StatelessWidget {
  /// Constructor
  const WorkoutCreateScreen({super.key});

  /// Route name
  static const routeName = 'workout_create';

  /// Path name where eid is the id of the exercise
  static const routePath = 'workout/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.backgroundSecondary,
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: context.colorScheme.backgroundSecondary,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(
            CupertinoIcons.xmark,
          ),
          color: context.colorScheme.foregroundPrimary,
          iconSize: 24,
        ),
        middle: Text(
          'Create Workout',
          style: TextStyle(color: context.colorScheme.foregroundPrimary),
        ),
      ),
      body: WorkoutFlow(
        initialWorkout: Workout(
          id: null,
        ),
      )
    );
  }
}
