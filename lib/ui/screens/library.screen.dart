import 'package:flex_workout_logger/features/exercises/ui/containers/exercises_list.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Exercises library screen
class ExercisesLibraryScreen extends StatelessWidget {
  /// Constructor
  const ExercisesLibraryScreen({super.key});

  /// Route name
  static const routeName = 'library/exercises';

  /// Path name
  static const routePath = 'library/exercises';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: CustomScrollView(
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Library',
              style: TextStyle(color: context.colorScheme.foreground),
            ),
            backgroundColor: context.colorScheme.offBackground,
            border: null,
          ),
          const SliverToBoxAdapter(child: ExercisesList()),
        ],
      ),
    );
  }
}
