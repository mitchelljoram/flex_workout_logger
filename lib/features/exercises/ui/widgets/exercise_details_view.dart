import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/ui/widgets/icon_text_button.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The detail view of an exercise
class ExerciseDetailsView extends StatelessWidget {
  ///
  const ExerciseDetailsView({required this.exercise, super.key});

  /// The exercise the card represents
  final ExerciseDetailsEntity exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Row holds summary
        Row(
          children: [
            // if (exercise.baseExercise != null)
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         exercise.baseExercise!.name,
            //         style: context.textTheme.bodyLarge.copyWith(
            //           color: context.colorScheme.foreground,
            //         ),
            //       ),
            //       Text(
            //         'Variation',
            //         style: context.textTheme.bodySmall.copyWith(
            //           color: context.colorScheme.mutedForeground,
            //         ),
            //       ),
            //     ],
            //   ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chest Press',
                  style: context.textTheme.bodyLarge.copyWith(
                    color: context.colorScheme.foreground,
                  ),
                ),
                Text(
                  'Variation',
                  style: context.textTheme.bodySmall.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '223.4',
                      style: context.textTheme.bodyLarge.copyWith(
                        color: context.colorScheme.foreground,
                      ),
                    ),
                    const SizedBox(
                      width: AppLayout.extraMiniPadding,
                    ),
                    Text(
                      'lbs',
                      style: context.textTheme.bodySmall.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
                Text(
                  '~1RM',
                  style: context.textTheme.bodySmall.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: AppLayout.defaultPadding,
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '205',
                      style: context.textTheme.bodyLarge.copyWith(
                        color: context.colorScheme.foreground,
                      ),
                    ),
                    const SizedBox(
                      width: AppLayout.extraMiniPadding,
                    ),
                    Text(
                      'lbs',
                      style: context.textTheme.bodySmall.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Max weight',
                  style: context.textTheme.bodySmall.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppLayout.defaultPadding),

        /// Hold buttons
        Row(
          children: [
            IconTextButton(
              icon: CupertinoIcons.pencil,
              text: 'Edit',
              onPressed: () => {
                // context.goNamed(
                //   ExercisesEditScreen.routeName,
                //   pathParameters: {
                //     'eid': exercise.id,
                //   },
                // )
              }
            ),
            const SizedBox(width: AppLayout.defaultPadding),
            const IconTextButton(
              icon: CupertinoIcons.flag,
              text: 'Goal',
              onPressed: null,
            ),
            const SizedBox(width: AppLayout.defaultPadding),
            const IconTextButton(
              icon: CupertinoIcons.square_on_square,
              text: 'Duplicate',
              onPressed: null,
            ),
            const SizedBox(width: AppLayout.defaultPadding),
            IconTextButton(
              icon: CupertinoIcons.trash,
              text: 'Delete',
              onPressed: () => {
                // showDialog<void>(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return AlertDialog(
                //       title: const Text('Are you sure about that?'),
                //       content: const Text('This will delete the exercise'),
                //       actions: [
                //         TextButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: const Text('Cancel'),
                //         ),
                //         TextButton(
                //           onPressed: () {
                //             ref
                //                 .read(
                //                   exercisesDeleteControllerProvider(exercise.id)
                //                       .notifier,
                //                 )
                //                 .handle();

                //             ref
                //                 .read(exercisesListControllerProvider.notifier)
                //                 .deleteExercise(exercise);

                //             Navigator.of(context).pop(); // Pop the dialog
                //             context.pop(); // Pop the screen
                //           },
                //           child: const Text('Confirm'),
                //         ),
                //       ],
                //     );
                //   },
                // ),
              },
            ),
          ],
        ),

        const SizedBox(
          height: AppLayout.defaultPadding,
        ),
        Divider(
          color: context.colorScheme.divider,
        ),
        const SizedBox(
          height: AppLayout.defaultPadding,
        ),

        /// General information
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (exercise.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppLayout.smallPadding,
                  ),
                  child: Text(
                    exercise.description,
                    style: context.textTheme.bodyMedium.copyWith(
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ),
              const SizedBox(height: AppLayout.defaultPadding),
              Wrap(
                spacing: AppLayout.miniPadding,
                runSpacing: AppLayout.miniPadding,
                children: [
                  if (exercise.movementPattern != null)
                    _bubble(
                      context,
                      exercise.movementPattern!.icon,
                      exercise.movementPattern!.name,
                    ),
                  _bubble(
                    context, 
                    'engagement.100x100.png',
                    exercise.engagement.name,
                  ),
                  _bubble(
                    context, 
                    'type.100x100.png',
                    exercise.type.name,
                  ),
                ],
              ),
              const SizedBox(height: AppLayout.defaultPadding),
            ],
          ),
        ),

        // TODO: Overview
          // TODO: Muscle groups targeted
          // TODO: History
        // TODO: Insights and analytics
        // TODO: Variants and similar exercises
      ],
    );
  }

  Widget _bubble(BuildContext context, String icon, String text) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      child: Container(
        color: context.colorScheme.muted,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.defaultPadding,
          vertical: AppLayout.extraMiniPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageIcon(
              AssetImage('assets/icons/${icon}'),
              size: 12,
            ),
            const SizedBox(
              width: AppLayout.extraMiniPadding,
            ),
            Text(
              text,
              style: context.textTheme.bodySmall.copyWith(
                color: context.colorScheme.foreground,
              ),
            ),
          ],
        )
      ),
    );
  }
}
