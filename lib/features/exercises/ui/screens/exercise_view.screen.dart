import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_view.controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/exercise_details_view.dart';
import 'package:flex_workout_logger/ui/widgets/app_error.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail View Screen
class ExerciseViewScreen extends ConsumerWidget {
  /// Constructor
  const ExerciseViewScreen({required this.id, super.key});

  /// Exercise id
  final String id;

  /// Route name
  static const routeName = 'exercises_view';

  /// Path name where eid is the id of the exercise
  static const routePath = 'exercises/:eid';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercise = ref.watch(exercisesViewControllerProvider(id));

    return Scaffold(
      backgroundColor: context.colorScheme.backgroundPrimary,
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: context.colorScheme.backgroundSecondary,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
          color: context.colorScheme.foregroundPrimary,
          iconSize: 24,
        ),
        middle: exercise.when(
          data: (data) => Text(
            data.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: context.colorScheme.foregroundPrimary),
          ),
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const Text(''),
        ),
        trailing: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(CupertinoIcons.info_circle,),
          color: context.colorScheme.foregroundPrimary,
          iconSize: 20,
        ),
      ),
      body: CustomScrollView(
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: <Widget>[
          exercise.when(
            data: (data) => SliverToBoxAdapter(
              child: ExerciseDetailsView(exercise: data),
            ),
            error: (o, e) => SliverToBoxAdapter(
              child: AppError(
                title: o.toString(),
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          // TODO: Overview
            // TODO: Muscle groups targeted
            // TODO: History
          // TODO: Insights and analytics
          // TODO: Variants and similar exercises
        ],
      ),
    );
  }
}
