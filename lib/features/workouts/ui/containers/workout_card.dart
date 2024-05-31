import 'package:dotted_border/dotted_border.dart';
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_delete.controller.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_list.controller.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/workout.entity.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

/// A selectable card with [Workout Title]
class WorkoutCard extends ConsumerWidget {
  ///
  const WorkoutCard({required this.workout, super.key});

  /// The exercise the card represents
  final WorkoutEntity workout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      groupTag: '0',
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (BuildContext context) => {
              // context.goNamed(
              //   WorkoutEditScreen.routeName,
              //   pathParameters: {
              //     'eid': workout.id,
              //   },
              // ),
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
                              workoutDeleteControllerProvider(workout.id)
                                  .notifier,
                            )
                            .handle();

                          ref
                            .read(workoutListControllerProvider.notifier)
                            .deleteWorkout(workout);

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
      child: WorkoutListTile(
        workout: workout,
        trailingIcon: CupertinoIcons.info_circle,
        onTap: () => {
          // context.goNamed(
          //   WorkoutViewScreen.routeName,
          //   pathParameters: {
          //     'eid': workout.id,
          //   },
          // )
        },
      ),
    );
  }
}

/// A selectable exercise card
class WorkoutListTile extends StatelessWidget {
  ///
  const WorkoutListTile({
    required this.workout,
    this.onTap,
    this.trailingIcon,
    super.key,
  });

  /// Workout the card represents
  final WorkoutEntity workout;

  /// On tap callback
  final void Function()? onTap;

  /// Trailing Icon
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        workout.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.labelLarge.copyWith(
          color: context.colorScheme.foregroundPrimary,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          Text(
            workout.focus,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelMedium.copyWith(
              color: context.colorScheme.foregroundSecondary,
            ),
          ),
          SizedBox(width: AppLayout.defaultPadding),
          Text(
            workout.numberOfLifts.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelMedium.copyWith(
              color: context.colorScheme.foregroundSecondary,
            ),
          ),
          SizedBox(width: AppLayout.defaultPadding),
          Text(
            '~${workout.estimatedTime.toString()} mins',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelMedium.copyWith(
              color: context.colorScheme.foregroundSecondary,
            ),
          ),
        ],
      ),
      onTap: onTap,
      leading: Container(
        height: 27,
        width: 27,
        child: workout.icon.isNotEmpty ?
          Image(
            image: AssetImage('assets/icons/exercises/${workout.icon}'),
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
