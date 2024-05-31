import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_list.controller.dart';
import 'package:flex_workout_logger/features/workouts/ui/containers/workout_card.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/ui/widgets/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Workout list on library screen
class WorkoutList extends ConsumerWidget {
  /// Constructor
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(workoutListControllerProvider);
    return exercises.when(
      data: (items) => items.isEmpty
          ? Padding(
              padding: EdgeInsets.all(AppLayout.miniPadding),
              child: Center(
                child: Text(
                  'No items found',
                  style: context.textTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.foregroundSecondary,
                  ),
                ),
              ),
            )
          : SlidableAutoCloseBehavior(
              child: Column(
                children: [
                  ...items.map(
                    (w) => Column(
                      children: [
                        WorkoutCard(
                          workout: w,
                        ),
                        Divider(
                          color: context.colorScheme.divider,
                          height: 1,
                          indent: 64,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      error: (o, e) => AppError(
        title: o.toString(),
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
