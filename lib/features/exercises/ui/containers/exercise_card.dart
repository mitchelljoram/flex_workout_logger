import 'package:dotted_border/dotted_border.dart';
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_delete.controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercise_edit.screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercise_view.screen.dart';
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

/// A selectable exercise card
class ExerciseListTile extends StatelessWidget {
  ///
  const ExerciseListTile({
    required this.exercise,
    this.onTap,
    this.trailingIcon,
    super.key,
  });

  /// Exercise the card represents
  final ExerciseDetailsEntity exercise;

  /// On tap callback
  final void Function()? onTap;

  /// Trailing Icon
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        exercise.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.labelLarge.copyWith(
          color: context.colorScheme.foregroundPrimary,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          if (exercise.movementPattern != null || exercise.baseExercise != null)
            Text(
              exercise.baseExercise != null
                  ? '${exercise.baseExercise!.name} Variation'
                  : exercise.movementPattern?.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium.copyWith(
                color: context.colorScheme.foregroundSecondary,
              ),
            ),
          if (exercise.movementPattern != null || exercise.baseExercise != null)
            const SizedBox(width: AppLayout.defaultPadding),
          if (exercise.primaryMuscleGroups.isNotEmpty)
            Expanded(
              child: Text(
                exercise.primaryMuscleGroups.map((e) => e.name).join(' • ') + (exercise.secondaryMuscleGroups.isNotEmpty ? (' • ') + exercise.secondaryMuscleGroups.map((e) => e.name).join(' • ') : ''),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium.copyWith(
                  color: context.colorScheme.foregroundSecondary,
                ),
              ),
            ),
        ],
      ),
      onTap: onTap,
      leading: Container(
        height: 27,
        width: 27,
        child: exercise.icon.isNotEmpty ?
          Image(
            image: AssetImage('assets/icons/exercises/${exercise.icon}'),
            fit: BoxFit.scaleDown,
          ) :
          DottedBorder(
            borderType: BorderType.Circle,
            dashPattern: const [2, 4],
            color: context.colorScheme.foregroundPrimary,
            child: Container()
          )
      ),
      trailing: (trailingIcon != null)
          ? Padding(
              padding: const EdgeInsets.only(left: AppLayout.miniPadding),
              child: Icon(
                trailingIcon,
                size: 16,
              ),
            )
          : null,
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        14,
        16,
      ),
    );
  }
}
