import 'package:flex_workout_logger/features/exercises/controllers/exercises_delete.controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercise_edit.screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercise_view.screen.dart';
import 'package:flex_workout_logger/ui/widgets/entity_list_tiles.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

/// A selectable card with [Exercise Title]
class ExercisesCard extends ConsumerWidget {
  ///
  const ExercisesCard({required this.exercise, super.key});

  /// The exercise the card represents
  final ExerciseDetailsEntity exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      groupTag: '0',
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (BuildContext context) => {
              context.goNamed(
                ExerciseEditScreen.routeName,
                pathParameters: {
                  'eid': exercise.id,
                },
              ),
            },
            backgroundColor: context.colorScheme.backgroundSecondary,
            foregroundColor: context.colorScheme.foregroundPrimary,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.pencil, size: 20),
                Text(
                  'Edit',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          CustomSlidableAction(
            onPressed: (BuildContext context) => {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title:Text(
                      'Are you sure about that?',
                      style: context.textTheme.headlineLarge.copyWith(
                        color: context.colorScheme.foregroundPrimary
                      ),
                    ),
                    backgroundColor: context.colorScheme.backgroundPrimary,
                    content: Text(
                      'This will delete the exercise',
                      style: context.textTheme.labelLarge.copyWith(
                        color: context.colorScheme.foregroundPrimary
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: context.textTheme.labelLarge.copyWith(
                            color: context.colorScheme.foregroundPrimary
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                            .read(
                              exercisesDeleteControllerProvider(exercise.id)
                                  .notifier,
                            )
                            .handle();

                          ref
                            .read(exercisesListControllerProvider.notifier)
                            .deleteExercise(exercise);

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Confirm',
                          style: context.textTheme.labelLarge.copyWith(
                            color: Color.fromRGBO(242, 184, 181, 1),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            },
            backgroundColor: context.colorScheme.foregroundPrimary,
            foregroundColor: context.colorScheme.backgroundPrimary,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.trash, size: 20),
                Text(
                  'Delete',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      child: ExerciseListTile(
        exercise: exercise,
        trailingIcon: CupertinoIcons.info_circle,
        onTap: () => {
          context.goNamed(
            ExerciseViewScreen.routeName,
            pathParameters: {
              'eid': exercise.id,
            },
          )
        },
      ),
    );
  }
}
