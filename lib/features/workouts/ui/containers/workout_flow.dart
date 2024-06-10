import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_create.controller.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_edit.controller.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_list.controller.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/workout.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/description.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/exercises.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/focus.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/icon.validation.dart';
import 'package:flex_workout_logger/features/workouts/domain/validations/name.validation.dart';
import 'package:flex_workout_logger/features/workouts/ui/containers/choose_exercises_controller.dart';
import 'package:flex_workout_logger/ui/widgets/choose_icon_controller.dart';
import 'package:flex_workout_logger/ui/widgets/flexable_textfield.dart';
import 'package:flex_workout_logger/ui/widgets/step_indicator.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Workout {
  final String? id;
  final WorkoutIcon icon;
  final WorkoutName name;
  final WorkoutFocus focus;
  final WorkoutDescription description;
  final WorkoutExercises exercises;
  
  Workout(
    {
      required this.id,
      required this.icon,
      required this.name,
      required this.focus,
      required this.description,
      required this.exercises,
    }
  );

  Workout copyWith({
    String? id,
    WorkoutIcon? icon,
    WorkoutName? name,
    WorkoutFocus? focus,
    WorkoutDescription? description,
    WorkoutExercises? exercises,
  }) {
    return Workout(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      focus: focus ?? this.focus,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
    );
  }
}

Workout workout = Workout(
  id: null,
  icon: WorkoutIcon(''),
  name: WorkoutName(''),
  focus: WorkoutFocus(''),
  description: WorkoutDescription(''),
  exercises: WorkoutExercises([]),
);

const int TOTAL_STEPS = 2;

enum WorkoutFlowStages {stage1, stage2}

List<Page> onGeneratePages(
  WorkoutFlowStages stage, 
  List<Page> pages,
) {
  switch(stage) {
    case WorkoutFlowStages.stage1: 
      return [WorkoutFlowPage1.page()];
    case WorkoutFlowStages.stage2: 
      return [WorkoutFlowPage2.page()];
    default: 
      return [WorkoutFlowPage1.page()];
  }
}

class WorkoutFlow extends ConsumerWidget{

  const WorkoutFlow({
    required this.initialWorkout,
    super.key
  });

  final Workout initialWorkout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    workout = initialWorkout;

    if (workout.id == null) {
      ref.listen<AsyncValue<WorkoutEntity?>>(
          workoutCreateControllerProvider, (previous, next) {
        next.maybeWhen(
          data: (data) {
            if (data == null) return;

            ref.read(workoutListControllerProvider.notifier).addWorkout(data);
            context.pop();
          },
          orElse: () {},
        );
      });
    } else {
      ref.listen<AsyncValue<WorkoutEntity?>>(
          workoutEditControllerProvider(workout.id!), (previous, next) {
        next.maybeWhen(
          data: (data) {
            if (previous?.value == null || data == null) return;

            ref.read(workoutListControllerProvider.notifier).editWorkout(data);
            context.pop();
          },
          orElse: () {},
        );
      });
    }

    return FlowBuilder<WorkoutFlowStages>(
      state: WorkoutFlowStages.stage1,
      onGeneratePages: onGeneratePages,
      onComplete: (WorkoutFlowStages stage) {
        if (workout.id == null) {
          // ref.read(workoutCreateControllerProvider.notifier).handle(
          // );
        } else {
          // ref.read(workoutEditControllerProvider(workout.id!).notifier).handle(
          // );
        }
      },
    );
  }
}


/// Workout Flow Page 1 - Icon, name, focus, program, and description
class WorkoutFlowPage1 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: WorkoutFlowPage1());

  @override
  ConsumerState<WorkoutFlowPage1> createState() => _WorkoutFlowPage1State();
}

class _WorkoutFlowPage1State extends ConsumerState<WorkoutFlowPage1> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 1;

  WorkoutIcon? _icon;
  WorkoutName? _name;
  WorkoutFocus? _focus;
  WorkoutDescription? _description;

  final _nameController = TextEditingController();
  final _focusController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    if (workout.icon.value.isRight()) {
      _icon = workout.icon;
    }
    if (workout.name.value.isRight()) {
      _nameController.text = workout.name.value.getOrElse((l) => '');
      _name = workout.name;
    }
    if (workout.focus.value.isRight()) {
      _focusController.text = workout.focus.value.getOrElse((l) => '');
      _focus = workout.focus;
    }
    if (workout.description.value.isRight()) {
      _descriptionController.text = workout.description.value.getOrElse((l) => '');
      _description = workout.description;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowNext() {
    workout = workout.copyWith(
      icon: _icon,
      name: _name,
      focus: _focus,
      description: _description,
    );

    context.flow<WorkoutFlowStages>().update((next) => WorkoutFlowStages.stage2);
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(workoutCreateControllerProvider);

    final errorText = res.maybeWhen(
      error: (error, stackTrace) => error.toString(),
      orElse: () => null,
    );

    final isLoading = res.maybeWhen(
      data: (_) => res.isRefreshing,
      loading: () => true,
      orElse: () => false,
    );

    return Scaffold(
      backgroundColor: context.colorScheme.backgroundSecondary,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: AppLayout.defaultPadding,
          right: AppLayout.defaultPadding,
          bottom: AppLayout.extraLargePadding
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            IconButton(
              onPressed: isLoading ?
                null :
                () {
                  if (!_formKey.currentState!.validate()) return;

                  handleFlowNext();
                },
              style: IconButton.styleFrom(
                backgroundColor: context.colorScheme.foregroundPrimary,
              ),
              icon: isLoading ?
                const CircularProgressIndicator() :
                Icon(
                  CupertinoIcons.chevron_right,
                  color: context.colorScheme.backgroundSecondary
                )
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: CustomScrollView(
              scrollBehavior: const CupertinoScrollBehavior(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppLayout.defaultPadding,
                            vertical: AppLayout.extraLargePadding,
                          ),
                          child: Column(
                            children: [
                              ChooseIconController(
                                onChanged: (value) => _icon = WorkoutIcon(value),
                                initialIcon: _icon?.value.getOrElse((l) => ''),
                              ),
                              const SizedBox(height: AppLayout.defaultPadding),
                              FlexableTextField(
                                label: 'Name',
                                hintText: 'Bench Focus',
                                errorText: errorText,
                                onChanged: (value) => _name = WorkoutName(value),
                                validator: (value) => _name?.validate,
                                controller: _nameController,
                                readOnly: isLoading,
                                isRequired: true,
                              ),
                              const SizedBox(height: AppLayout.defaultPadding),
                              FlexableTextField(
                                label: 'Focus',
                                hintText: 'Strength',
                                errorText: errorText,
                                onChanged: (value) => _focus = WorkoutFocus(value),
                                validator: (value) => _focus?.validate,
                                controller: _focusController,
                                readOnly: isLoading,
                                isRequired: true,
                              ),
                              const SizedBox(height: AppLayout.defaultPadding),

                              // TODO: Implement add to an existing program widget
                              // const SizedBox(height: AppLayout.defaultPadding),

                              FlexableTextField(
                                label: 'Description',
                                hintText: 'Describe the workout, including any additional setup that is required.',
                                errorText: errorText,
                                onChanged: (value) => _description = WorkoutDescription(value),
                                validator: (value) => _description?.validate,
                                controller: _descriptionController,
                                readOnly: isLoading,
                                isTextArea: true,
                                maxLength: MAX_DESCRIPTION_LENGTH,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: AppLayout.smallPadding,
                right: AppLayout.smallPadding,
                top: AppLayout.miniPadding,
              ),
              color: context.colorScheme.backgroundSecondary,
              child: StepIndicator(currentStep: _currentStep, totalSteps: TOTAL_STEPS),
            )
          ),
        ],
      ),
    );
  }
}


/// Workout Flow Page 2 - Exercises and Sets
class WorkoutFlowPage2 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: WorkoutFlowPage2());

  @override
  ConsumerState<WorkoutFlowPage2> createState() => _WorkoutFlowPage2State();
}

class _WorkoutFlowPage2State extends ConsumerState<WorkoutFlowPage2> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 2;

  WorkoutExercises? _exercises;

  @override
  void initState() {
    if (workout.exercises.value.isRight()) {
      _exercises = workout.exercises;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowNext() {
    workout = workout.copyWith(
      exercises: _exercises,
    );

    context.flow<WorkoutFlowStages>().complete();
  }

  void handleFlowPrev() {
    workout = workout.copyWith(
      exercises: _exercises,
    );

    context.flow<WorkoutFlowStages>().update((prev) => WorkoutFlowStages.stage1);
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(workoutCreateControllerProvider);

    final isLoading = res.maybeWhen(
      data: (_) => res.isRefreshing,
      loading: () => true,
      orElse: () => false,
    );

    return Scaffold(
      backgroundColor: context.colorScheme.backgroundSecondary,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: AppLayout.defaultPadding,
          right: AppLayout.defaultPadding,
          bottom: AppLayout.extraLargePadding
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: isLoading ?
                null :
                () {
                  handleFlowPrev();
                },
              style: IconButton.styleFrom(
                backgroundColor: context.colorScheme.foregroundPrimary,
              ),
              icon: isLoading ?
                const CircularProgressIndicator() :
                Icon(
                  CupertinoIcons.chevron_left,
                  color: context.colorScheme.backgroundSecondary
                )
            ),
            Spacer(),
            TextButton(
              onPressed: isLoading ?
                null :
                () {
                  if (!_formKey.currentState!.validate()) return;

                  handleFlowNext();
                },
              style: TextButton.styleFrom(
                backgroundColor: context.colorScheme.foregroundPrimary,
              ),
              child: isLoading ?
                const CircularProgressIndicator() :
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.defaultPadding,
                  ),
                  child: Text(
                    workout.id == null ? 'Create' : 'Save Changes',
                    style: context.textTheme.bodyLarge.copyWith(
                      color: context.colorScheme.backgroundSecondary,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: CustomScrollView(
              scrollBehavior: const CupertinoScrollBehavior(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppLayout.defaultPadding,
                            vertical: AppLayout.extraLargePadding,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Exercises',
                                style: context.textTheme.headlineLarge.copyWith(
                                  color: context.colorScheme.foregroundPrimary,
                                ),
                              ),
                              SizedBox(
                                height: AppLayout.largePadding,
                              ),
                              ChooseExercisesController(
                                onChanged: (value) => _exercises = WorkoutExercises(value), 
                                initialExercises: _exercises!.value.getOrElse((l) => []),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: AppLayout.smallPadding,
                right: AppLayout.smallPadding,
                top: AppLayout.miniPadding,
              ),
              color: context.colorScheme.backgroundSecondary,
              child: StepIndicator(currentStep: _currentStep, totalSteps: TOTAL_STEPS),
            )
          ),
        ],
      ),
    );
  }
}
