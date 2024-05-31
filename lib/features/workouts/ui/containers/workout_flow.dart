import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_create.controller.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_edit.controller.dart';
import 'package:flex_workout_logger/features/workouts/controllers/workout_list.controller.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/workout.entity.dart';
import 'package:flex_workout_logger/ui/widgets/choose_icon_controller.dart';
import 'package:flex_workout_logger/ui/widgets/flexable_textfield.dart';
import 'package:flex_workout_logger/ui/widgets/step_indicator.dart';
import 'package:flex_workout_logger/ui/widgets/weight_input.dart';
import 'package:flex_workout_logger/utils/date_time_extensions.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Workout {
  final String? id;
  
  Workout(
    {
      required this.id,
    }
  );

  Workout copyWith({
    String? id,
  }) {
    return Workout(
      id: id ?? this.id,
    );
  }
}

Workout workout = Workout(
  id: null,
);

const int TOTAL_STEPS = 2;

enum CreateWorkoutStages {stage1, stage2}

List<Page> onGeneratePages(
  CreateWorkoutStages stage, 
  List<Page> pages,
) {
  switch(stage) {
    case CreateWorkoutStages.stage1: 
      return [WorkoutCreateFormPage1.page()];
    case CreateWorkoutStages.stage2: 
      return [WorkoutCreateFormPage2.page()];
    default: 
      return [WorkoutCreateFormPage1.page()];
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

    return FlowBuilder<CreateWorkoutStages>(
      state: CreateWorkoutStages.stage1,
      onGeneratePages: onGeneratePages,
      onComplete: (CreateWorkoutStages stage) {
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


/// Workout Create Form Page 1 - Icon, name, focus, program, and description
class WorkoutCreateFormPage1 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: WorkoutCreateFormPage1());

  @override
  ConsumerState<WorkoutCreateFormPage1> createState() => _WorkoutCreateFormPage1State();
}

class _WorkoutCreateFormPage1State extends ConsumerState<WorkoutCreateFormPage1> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowNext() {
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


/// Workout Create Form Page 2 - Exercises and Sets
class WorkoutCreateFormPage2 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: WorkoutCreateFormPage2());

  @override
  ConsumerState<WorkoutCreateFormPage2> createState() => _WorkoutCreateFormPage2State();
}

class _WorkoutCreateFormPage2State extends ConsumerState<WorkoutCreateFormPage2> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 4;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowNext() {
  }

  void handleFlowPrev() {
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
