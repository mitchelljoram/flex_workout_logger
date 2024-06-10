import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_create.controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_delete.controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_weight.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/engagement.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/equipment.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/movement_pattern.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/muscle_groups.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/name.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/personal_record.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/type.validation.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercise_edit.screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercise_view.screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/muscle_groups_targeted.dart';
import 'package:flex_workout_logger/ui/widgets/bubbles.dart';
import 'package:flex_workout_logger/ui/widgets/icon_text_button.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The detail view of an exercise
class ExerciseDetailsView extends ConsumerWidget {
  ///
  const ExerciseDetailsView({required this.exercise, super.key});

  /// The exercise the card represents
  final ExerciseDetailsEntity exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<ExerciseDetailsEntity?>>(
        exercisesCreateControllerProvider, (previous, next) {
      next.maybeWhen(
        data: (data) {
          if (data == null) return;

          ref.read(exercisesListControllerProvider.notifier).addExercise(data);
          context.pop();
        },
        orElse: () {},
      );
    });

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
                            exercise.personalRecord!.oneRepMaxEstimateKgs.toString(),
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
                      context.goNamed(
                        ExerciseEditScreen.routeName,
                        pathParameters: {
                          'eid': exercise.id,
                        },
                      ),
                    }
                  ),
                  const SizedBox(width: AppLayout.defaultPadding),
                  IconTextButton(
                    icon: CupertinoIcons.flag,
                    text: 'Goal',
                    onPressed: null,
                  ),
                  const SizedBox(width: AppLayout.defaultPadding),
                  IconTextButton(
                    icon: CupertinoIcons.square_on_square,
                    text: 'Duplicate',
                    onPressed: () async {
                      final res = await ref.read(exercisesCreateControllerProvider.notifier).handle(
                        ExerciseDetailsIcon(exercise.icon),
                        ExerciseDetailsBaseExercise(null, exercise.baseExercise),
                        ExerciseDetailsName(exercise.name + ' copy'),
                        ExerciseDetailsDescription(exercise.description),
                        ExerciseDetailsMovementPattern(exercise.movementPattern),
                        ExerciseDetailsEquipment(exercise.equipment),
                        ExerciseDetailsEngagement(exercise.engagement),
                        ExerciseDetailsType(exercise.type),
                        ExerciseDetailsMuscleGroups(exercise.primaryMuscleGroups),
                        ExerciseDetailsMuscleGroups(exercise.secondaryMuscleGroups),
                        ExerciseDetailsBaseWeight(exercise.baseWeight),
                        ExerciseDetailsPersonalRecord(exercise.personalRecord),
                      );

                      if (res != null){
                        context.goNamed(
                          ExerciseViewScreen.routeName,
                          pathParameters: {
                            'eid': res,
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(width: AppLayout.defaultPadding),
                  IconTextButton(
                    icon: CupertinoIcons.trash,
                    text: 'Delete',
                    onPressed: () => {
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
                                  context.pop();
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
                        BubbleImageLabel(
                          label: exercise.movementPattern!.name,
                          backgroundColor: context.colorScheme.backgroundTertiary,
                          image: exercise.movementPattern!.icon,
                        ),
                        if (exercise.equipment != null)
                          BubbleImageLabel(
                            label: exercise.equipment!.name,
                            backgroundColor: context.colorScheme.backgroundTertiary,
                            image: exercise.equipment!.icon,
                          ),
                        BubbleImageLabel(
                          label: exercise.engagement.name,
                          backgroundColor: context.colorScheme.backgroundTertiary,
                          image: 'engagement.100x100.png',
                        ),
                        BubbleImageLabel(
                          label: exercise.type.name,
                          backgroundColor: context.colorScheme.backgroundTertiary,
                          image: 'type.100x100.png',
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
}
