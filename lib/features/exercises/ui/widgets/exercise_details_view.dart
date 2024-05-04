import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/muscle_groups_targeted.dart';
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container (
          color: context.colorScheme.backgroundSecondary,
          padding: EdgeInsets.all(AppLayout.defaultPadding),
          child:Column(
            children: [
              /// Row holds summary
              Row(
                children: [
                  if (exercise.baseExercise != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.baseExercise!.name,
                          style: context.textTheme.bodyLarge.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.foregroundPrimary,
                          ),
                        ),
                        Text(
                          'Variation',
                          style: context.textTheme.labelMedium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.foregroundSecondary,
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
                            exercise.personalRecord!.maxWeightKgs.toString(),
                            style: context.textTheme.bodyLarge.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.foregroundPrimary,
                            ),
                          ),
                          const SizedBox(
                            width: AppLayout.extraMiniPadding,
                          ),
                          Text(
                            'kgs',
                            style: context.textTheme.labelMedium.copyWith(
                              color: context.colorScheme.foregroundSecondary,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '~1RM',
                        style: context.textTheme.labelMedium.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.foregroundSecondary,
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
                            exercise.personalRecord!.maxWeightKgs.toString(),
                            style: context.textTheme.bodyLarge.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.foregroundPrimary,
                            ),
                          ),
                          const SizedBox(
                            width: AppLayout.extraMiniPadding,
                          ),
                          Text(
                            'kgs',
                            style: context.textTheme.labelMedium.copyWith(
                              color: context.colorScheme.foregroundSecondary,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Max weight',
                        style: context.textTheme.labelMedium.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.foregroundSecondary,
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
                      Column(
                        children: [
                          Text(
                            exercise.description,
                            style: context.textTheme.bodyMedium.copyWith(
                              color: context.colorScheme.foregroundSecondary,
                            ),
                          ),
                          const SizedBox(
                            height: AppLayout.defaultPadding,
                          ),
                        ]
                      ),
                    Wrap(
                      spacing: AppLayout.miniPadding,
                      runSpacing: AppLayout.miniPadding,
                      children: [
                        _bubble(
                          context,
                          exercise.movementPattern!.name,
                          exercise.movementPattern!.icon,
                        ),
                        if (exercise.equipment != null)
                          _bubble(
                            context,
                            exercise.equipment!.name,
                            exercise.equipment!.icon,
                          ),
                        _bubble(
                          context, 
                          exercise.engagement.name,
                          'engagement.100x100.png',
                        ),
                        _bubble(
                          context, 
                          exercise.type.name,
                          'type.100x100.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
        Padding(
          padding: EdgeInsets.all(AppLayout.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overview',
                style: context.textTheme.headlineMedium.copyWith(
                  color: context.colorScheme.foregroundPrimary,
                ),
              ),
              SizedBox(
                height: AppLayout.defaultPadding,
              ),
              MuscleGroupsTargeted(
                primaryTargeted: exercise.primaryMuscleGroups, 
                secondaryTargeted: exercise.secondaryMuscleGroups,
              ),
                // TODO: History
              // TODO: Insights and analytics
              // TODO: Variants and similar exercises
            ],
          ),
        ),
      ],
    );
  }

  Widget _bubble(BuildContext context, String text, String? icon) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      child: Container(
        color: context.colorScheme.backgroundTertiary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.smallPadding,
          vertical: AppLayout.extraMiniPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && icon.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  right: AppLayout.miniPadding,
                ),
                child: ImageIcon(
                  AssetImage('assets/icons/${icon}'),
                  size: 12,
                ),
              ),
            Text(
              text,
              style: context.textTheme.labelMedium.copyWith(
                color: context.colorScheme.foregroundPrimary,
              ),
            ),
          ],
        )
      ),
    );
  }
}