import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_create.controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_edit.controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/base_weight.entity.dart';
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
import 'package:flex_workout_logger/features/exercises/ui/containers/choose_base_exercise_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/choose_base_weight_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/containers/choose_equipment_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/containers/choose_movement_pattern_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/containers/choose_muscle_groups_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/flexable_radio_list.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/personal_record_controller.dart';
import 'package:flex_workout_logger/ui/widgets/choose_icon_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/variation_segment_controller.dart';
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

class ExerciseDetails {
  final String? id;
  final ExerciseDetailsIcon icon;
  final ExerciseDetailsBaseExercise baseExercise;
  final ExerciseDetailsName name;
  final ExerciseDetailsDescription description;
  final ExerciseDetailsMovementPattern movementPattern;
  final ExerciseDetailsEquipment equipment;
  final ExerciseDetailsEngagement engagement;
  final ExerciseDetailsType type;
  final ExerciseDetailsMuscleGroups primaryMuscleGroups;
  final ExerciseDetailsMuscleGroups secondaryMuscleGroups;
  final ExerciseDetailsBaseWeight baseWeight;
  final ExerciseDetailsPersonalRecord personalRecord;

  ExerciseDetails(
    {
      required this.id,
      required this.icon,
      required this.baseExercise,
      required this.name,
      required this.description,
      required this.movementPattern,
      required this.equipment,
      required this.engagement,
      required this.type,
      required this.primaryMuscleGroups,
      required this.secondaryMuscleGroups,
      required this.baseWeight,
      required this.personalRecord,
    }
  );

  ExerciseDetails copyWith({
    String? id,
    ExerciseDetailsIcon? icon,
    ExerciseDetailsBaseExercise? baseExercise,
    ExerciseDetailsName? name,
    ExerciseDetailsDescription? description,
    ExerciseDetailsMovementPattern? movementPattern,
    ExerciseDetailsEquipment? equipment,
    ExerciseDetailsEngagement? engagement,
    ExerciseDetailsType? type,
    ExerciseDetailsMuscleGroups? primaryMuscleGroups,
    ExerciseDetailsMuscleGroups? secondaryMuscleGroups,
    ExerciseDetailsBaseWeight? baseWeight,
    ExerciseDetailsPersonalRecord? personalRecord,
  }) {
    return ExerciseDetails(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      baseExercise: baseExercise ?? this.baseExercise,
      name: name ?? this.name,
      description: description ?? this.description,
      movementPattern: movementPattern ?? this.movementPattern,
      equipment: equipment ?? this.equipment,
      engagement: engagement ?? this.engagement,
      type: type ?? this.type,
      primaryMuscleGroups: primaryMuscleGroups ?? this.primaryMuscleGroups,
      secondaryMuscleGroups: secondaryMuscleGroups ?? this.secondaryMuscleGroups,
      baseWeight: baseWeight ?? this.baseWeight,
      personalRecord: personalRecord ?? this.personalRecord,
    );
  }
}

ExerciseDetails exerciseDetails = ExerciseDetails(
  id: null,
  icon: ExerciseDetailsIcon(''),
  baseExercise: ExerciseDetailsBaseExercise(null, null),
  name: ExerciseDetailsName(''),
  description: ExerciseDetailsDescription(''),
  movementPattern: ExerciseDetailsMovementPattern(null),
  equipment: ExerciseDetailsEquipment(null),
  engagement: ExerciseDetailsEngagement(Engagement.bilateral),
  type: ExerciseDetailsType(ExerciseType.repitition),
  primaryMuscleGroups: ExerciseDetailsMuscleGroups([]),
  secondaryMuscleGroups: ExerciseDetailsMuscleGroups([]),
  baseWeight: ExerciseDetailsBaseWeight(null),
  personalRecord: ExerciseDetailsPersonalRecord(null),
);

const int TOTAL_STEPS = 4;

enum ExerciseDetailsFlowStages {stage1, stage2, stage3, stage4, baseWeight}

List<Page> onGeneratePages(
  ExerciseDetailsFlowStages stage, 
  List<Page> pages,
) {
  switch(stage) {
    case ExerciseDetailsFlowStages.stage1: 
      return [ExerciseDetailsFlowPage1.page()];
    case ExerciseDetailsFlowStages.stage2: 
      return [ExerciseDetailsFlowPage2.page()];
    case ExerciseDetailsFlowStages.stage3: 
      return [ExerciseDetailsFlowPage3.page()];
    case ExerciseDetailsFlowStages.stage4: 
      return [ExerciseDetailsFlowPage4.page()];
    case ExerciseDetailsFlowStages.baseWeight:
      return [ExerciseDetailsFlowBaseWeight.page()];
    default: 
      return [ExerciseDetailsFlowPage1.page()];
  }
}

class ExerciseDetailsFlow extends ConsumerWidget{

  const ExerciseDetailsFlow({
    required this.initialExerciseDetails,
    super.key
  });

  final ExerciseDetails initialExerciseDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    exerciseDetails = initialExerciseDetails;

    if (exerciseDetails.id == null) {
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
    } else {
      ref.listen<AsyncValue<ExerciseDetailsEntity?>>(
          exercisesEditControllerProvider(exerciseDetails.id!), (previous, next) {
        next.maybeWhen(
          data: (data) {
            if (previous?.value == null || data == null) return;

            ref.read(exercisesListControllerProvider.notifier).editExercise(data);
            context.pop();
          },
          orElse: () {},
        );
      });
    }

    return FlowBuilder<ExerciseDetailsFlowStages>(
      state: ExerciseDetailsFlowStages.stage1,
      onGeneratePages: onGeneratePages,
      onComplete: (ExerciseDetailsFlowStages stage) {
        if (exerciseDetails.id == null) {
          ref.read(exercisesCreateControllerProvider.notifier).handle(
            exerciseDetails.icon,
            exerciseDetails.baseExercise,
            exerciseDetails.name,
            exerciseDetails.description,
            exerciseDetails.movementPattern,
            exerciseDetails.equipment,
            exerciseDetails.engagement,
            exerciseDetails.type,
            exerciseDetails.primaryMuscleGroups,
            exerciseDetails.secondaryMuscleGroups,
            exerciseDetails.baseWeight,
            exerciseDetails.personalRecord
          );
        } else {
          ref.read(exercisesEditControllerProvider(exerciseDetails.id!).notifier).handle(
            exerciseDetails.icon,
            exerciseDetails.baseExercise,
            exerciseDetails.name,
            exerciseDetails.description,
            exerciseDetails.movementPattern,
            exerciseDetails.equipment,
            exerciseDetails.engagement,
            exerciseDetails.type,
            exerciseDetails.primaryMuscleGroups,
            exerciseDetails.secondaryMuscleGroups,
            exerciseDetails.baseWeight,
            exerciseDetails.personalRecord
          );
        }
      },
    );
  }
}


/// Exercise Details Create Form Page 1 - Icon, base exercise, name, and description
class ExerciseDetailsFlowPage1 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: ExerciseDetailsFlowPage1());

  @override
  ConsumerState<ExerciseDetailsFlowPage1> createState() => _ExerciseDetailsFlowPage1State();
}

class _ExerciseDetailsFlowPage1State extends ConsumerState<ExerciseDetailsFlowPage1> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 1;

  ExerciseDetailsIcon? _icon;
  ExerciseDetailsBaseExercise? _baseExercise;
  ExerciseDetailsName? _name;
  ExerciseDetailsDescription? _description;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  late int _selectedVariation;

  @override
  void initState() {
    if (exerciseDetails.icon.value.isRight()) {
      _icon = exerciseDetails.icon;
    }
    if (exerciseDetails.baseExercise.value.isRight()) {
      if (exerciseDetails.baseExercise.value.getOrElse((l) => null) != null){
        _selectedVariation = 2;
      } else {
        _selectedVariation = 1;
      }

      _baseExercise = exerciseDetails.baseExercise;
    }
    if (exerciseDetails.name.value.isRight()) {
      _nameController.text = exerciseDetails.name.value.getOrElse((l) => '');
      _name = exerciseDetails.name;
    }
    if (exerciseDetails.description.value.isRight()) {
      _descriptionController.text = exerciseDetails.description.value.getOrElse((l) => '');
      _description = exerciseDetails.description;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowNext() {
    exerciseDetails = exerciseDetails.copyWith(
      icon: _icon,
      baseExercise: _baseExercise,
      name: _name,
      description: _description,
    );

    context.flow<ExerciseDetailsFlowStages>().update((next) => ExerciseDetailsFlowStages.stage2);
  }

  void _onVariationChanged(int index) {
    setState(() {
      if (index == 1) {
        _baseExercise = ExerciseDetailsBaseExercise(null, null);
      }
      _selectedVariation = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(exercisesCreateControllerProvider);

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
                              Text(
                                'Is this a completely new exercise or a variation on an existing one?',
                                style: context.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: AppLayout.smallPadding),
                              VariationSegementedController(
                                selectedValue: _selectedVariation,
                                onValueChanged: _onVariationChanged,
                              ),
                              const SizedBox(height: AppLayout.defaultPadding),
                              ChooseIconController(
                                onChanged: (value) => {_icon = ExerciseDetailsIcon(value)},
                                initialIcon: _icon?.value.getOrElse((l) => ''),
                              ),
                              const SizedBox(height: AppLayout.defaultPadding),
                              FlexableTextField(
                                label: _selectedVariation == 1 ? 'Exercise Name' : 'Variation Name',
                                hintText: _selectedVariation == 1
                                    ? 'Bench Press, Squat, etc.'
                                    : 'Paused, 3” Bands, Alternating, etc...',
                                errorText: errorText,
                                onChanged: (value) => _name = ExerciseDetailsName(value),
                                validator: (value) => _name?.validate,
                                controller: _nameController,
                                readOnly: isLoading,
                                isRequired: true,
                              ),
                              const SizedBox(height: AppLayout.defaultPadding),
                              if (_selectedVariation == 2)
                                ChooseBaseExerciseController(
                                  validator: (value) => _baseExercise?.validate,
                                  onChanged: (value) {
                                    _baseExercise = ExerciseDetailsBaseExercise(null, value);

                                    if (_baseExercise!.value.isRight()) {
                                      exerciseDetails = exerciseDetails.copyWith(
                                        movementPattern: ExerciseDetailsMovementPattern(value.movementPattern),
                                        engagement: ExerciseDetailsEngagement(value.engagement),
                                        type: ExerciseDetailsType(value.type),
                                        // primaryMuscleGroups: ExerciseDetailsMuscleGroups(value.primaryMuscleGroups),
                                        // secondaryMuscleGroups: ExerciseDetailsMuscleGroups(value.secondaryMuscleGroups),
                                      );
                                    }
                                  },
                                  initialValue: _baseExercise?.value.getOrElse((l) => null),
                                ),
                              FlexableTextField(
                                label: 'Description',
                                hintText: _selectedVariation == 1
                                    ? 'Describe the exercise, including any additional setup that is required.'
                                    : 'Describe of the variation including the main differences between itself and its base exercise.',
                                errorText: errorText,
                                onChanged: (value) => _description = ExerciseDetailsDescription(value),
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


/// Exercise Details Create Form Page 2 - Movement pattern, equipment, engagement, and type
class ExerciseDetailsFlowPage2 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: ExerciseDetailsFlowPage2());

  @override
  ConsumerState<ExerciseDetailsFlowPage2> createState() => _ExerciseDetailsFlowPage2State();
}

class _ExerciseDetailsFlowPage2State extends ConsumerState<ExerciseDetailsFlowPage2> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 2;

  ExerciseDetailsMovementPattern? _movementPattern;
  ExerciseDetailsEquipment? _equipment;
  ExerciseDetailsEngagement? _engagement;
  ExerciseDetailsType? _type;

  @override
  void initState() {
    if (exerciseDetails.movementPattern.value.isRight()) {
      _movementPattern = exerciseDetails.movementPattern;
    }
    if (exerciseDetails.equipment.value.isRight()) {
      _equipment = exerciseDetails.equipment;
    }
    if (exerciseDetails.engagement.value.isRight()) {
      _engagement = exerciseDetails.engagement;
    }
    if (exerciseDetails.type.value.isRight()) {
      _type = exerciseDetails.type;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowPrev() {
    exerciseDetails = exerciseDetails.copyWith(
      movementPattern: _movementPattern,
      equipment: _equipment,
      engagement: _engagement,
      type: _type,
    );

    context.flow<ExerciseDetailsFlowStages>().update((prev) => ExerciseDetailsFlowStages.stage1);
  }

  void handleFlowNext() {
    exerciseDetails = exerciseDetails.copyWith(
      movementPattern: _movementPattern,
      equipment: _equipment,
      engagement: _engagement,
      type: _type,
    );

    context.flow<ExerciseDetailsFlowStages>().update((next) => ExerciseDetailsFlowStages.stage3);
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(exercisesCreateControllerProvider);

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
                              ChooseMovementPatternController(
                                validator: (value) => _movementPattern?.validate, 
                                onChanged: (value) => _movementPattern = ExerciseDetailsMovementPattern(value),
                                initialValue: _movementPattern?.value.getOrElse((l) => null),
                              ),
                              ChooseEquipmentController(
                                validator: (value) => _equipment?.validate, 
                                onChanged: (value) => _equipment = ExerciseDetailsEquipment(value),
                                initialValue: _equipment?.value.getOrElse((l) => null),
                              ),
                              FlexableRadioList<Engagement>(
                                items: Engagement.values.toList(), 
                                onSelected: (Enumeration<Enum>? value) => _engagement = ExerciseDetailsEngagement(value as Engagement), 
                                selectedValue: _engagement?.value.getOrElse((l) => Engagement.bilateral), 
                                labelText: 'Body Engagement',
                                description: 'How the body engages with the lift during the movement.',
                              ),
                              const SizedBox(
                                height: AppLayout.defaultPadding,
                              ),
                              FlexableRadioList<ExerciseType>(
                                items: ExerciseType.values.toList(), 
                                onSelected: (Enumeration<Enum>? value) => _type = ExerciseDetailsType(value as ExerciseType),
                                selectedValue: _type?.value.getOrElse((l) => ExerciseType.repitition), 
                                labelText: 'Exercise Type',
                                description: 'How are you going to record your exercise.',
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


/// Exercise Details Create Form Page 3 - Muscle groups
class ExerciseDetailsFlowPage3 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: ExerciseDetailsFlowPage3());

  @override
  ConsumerState<ExerciseDetailsFlowPage3> createState() => _ExerciseDetailsFlowPage3State();
}

class _ExerciseDetailsFlowPage3State extends ConsumerState<ExerciseDetailsFlowPage3> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 3;

  ExerciseDetailsMuscleGroups? _primaryMuscleGroups;
  ExerciseDetailsMuscleGroups? _secondaryMuscleGroups;
  ExerciseDetailsMovementPattern? _movementPattern;

  @override
  void initState() {
    if (exerciseDetails.primaryMuscleGroups.value.isRight()) {
      _primaryMuscleGroups = exerciseDetails.primaryMuscleGroups;
    }
    if (exerciseDetails.secondaryMuscleGroups.value.isRight()) {
      _secondaryMuscleGroups = exerciseDetails.secondaryMuscleGroups;
    }
    if (exerciseDetails.movementPattern.value.isRight()) {
      _movementPattern = exerciseDetails.movementPattern;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowPrev() {
    exerciseDetails = exerciseDetails.copyWith(
      primaryMuscleGroups: _primaryMuscleGroups,
      secondaryMuscleGroups: _secondaryMuscleGroups,
    );

    context.flow<ExerciseDetailsFlowStages>().update((prev) => ExerciseDetailsFlowStages.stage2);
  }

  void handleFlowNext() {
    exerciseDetails = exerciseDetails.copyWith(
      primaryMuscleGroups: _primaryMuscleGroups,
      secondaryMuscleGroups: _secondaryMuscleGroups,
    );

    context.flow<ExerciseDetailsFlowStages>().update((next) => ExerciseDetailsFlowStages.stage4);
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(exercisesCreateControllerProvider);

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
                          child: ChooseMuscleGroupsController(
                            onChanged: (primary, secondary) {
                              _primaryMuscleGroups = ExerciseDetailsMuscleGroups(primary);
                              _secondaryMuscleGroups = ExerciseDetailsMuscleGroups(secondary);
                            }, 
                            initialPrimaryMuscleGroups: _primaryMuscleGroups!.value.getOrElse((l) => []), 
                            initialSeconadryMuscleGroups: _secondaryMuscleGroups!.value.getOrElse((l) => []),
                            movementPattern: _movementPattern!.value.getOrElse((l) => null),
                          ),
                        ),
                      ),
                    ]
                  )
                )
              ]
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


/// Exercise Details Create Form Page 4 - Base weight, personal record
class ExerciseDetailsFlowPage4 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: ExerciseDetailsFlowPage4());

  @override
  ConsumerState<ExerciseDetailsFlowPage4> createState() => _ExerciseDetailsFlowPage4State();
}

class _ExerciseDetailsFlowPage4State extends ConsumerState<ExerciseDetailsFlowPage4> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 4;

  ExerciseDetailsBaseWeight? _baseWeight;
  ExerciseDetailsPersonalRecord? _personalRecord;

  @override
  void initState() {
    if (exerciseDetails.baseWeight.value.isRight()) {
      _baseWeight = exerciseDetails.baseWeight;
    }
    if (exerciseDetails.personalRecord.value.isRight()) {
      _personalRecord = exerciseDetails.personalRecord;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowNext() {
    exerciseDetails = exerciseDetails.copyWith(
      baseWeight: _baseWeight,
      personalRecord: _personalRecord,
    );

    context.flow<ExerciseDetailsFlowStages>().complete();
  }

  void handleFlowPrev() {
    exerciseDetails = exerciseDetails.copyWith(
      baseWeight: _baseWeight,
      personalRecord: _personalRecord,
    );

    context.flow<ExerciseDetailsFlowStages>().update((prev) => ExerciseDetailsFlowStages.stage3);
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(exercisesCreateControllerProvider);

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
                    exerciseDetails.id == null ? 'Create' : 'Save Changes',
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
                              ChooseBaseWeightController(
                                initialValue: _baseWeight?.value.getOrElse((l) => null),
                                onChanged: (value) => _baseWeight = ExerciseDetailsBaseWeight(value),
                                handleFlowBaseWeight: () {
                                  exerciseDetails = exerciseDetails.copyWith(
                                    baseWeight: _baseWeight,
                                    personalRecord: _personalRecord,
                                  );

                                  context.flow<ExerciseDetailsFlowStages>().update((next) => ExerciseDetailsFlowStages.baseWeight);
                                },
                              ),
                              const SizedBox(
                                height: AppLayout.defaultPadding,
                              ),
                              if (exerciseDetails.type.value.getOrElse((l) => ExerciseType.repitition) == ExerciseType.repitition)
                                PersonalRecordController(
                                  initialValue: _personalRecord?.value.getOrElse((l) => null),
                                  onChanged: (value) => _personalRecord = ExerciseDetailsPersonalRecord(value),
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

/// Exercise Details Create Form - Base weight
class ExerciseDetailsFlowBaseWeight extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: ExerciseDetailsFlowBaseWeight());

  @override
  ConsumerState<ExerciseDetailsFlowBaseWeight> createState() => _ExerciseDetailsFlowBaseWeightState();
}

class _ExerciseDetailsFlowBaseWeightState extends ConsumerState<ExerciseDetailsFlowBaseWeight> {
  ExerciseDetailsBaseWeight? _baseWeight;
  double _weight = 0.0;
  WeightUnits _initialUnit = WeightUnits.kilograms;
  Assisted _assisted = Assisted.notAssisted;
  BodyWeight _bodyWeight = BodyWeight.custom;

  @override
  void initState() {
    if (exerciseDetails.baseWeight.value.isRight()) {
      _baseWeight = exerciseDetails.baseWeight;

      if (_baseWeight!.value.getOrElse((l) => null)!.weightLbs != 0.0) {
        _weight = _baseWeight!.value.getOrElse((l) => null)!.weightLbs;
        _initialUnit = WeightUnits.pounds;
      } else {
        _weight = _baseWeight!.value.getOrElse((l) => null)!.weightKgs;
      }

      if (_baseWeight!.value.getOrElse((l) => null)!.assisted == true) {
        _assisted = Assisted.assisted;
      }

      if (_baseWeight!.value.getOrElse((l) => null)!.bodyWeight == true) {
        _bodyWeight = BodyWeight.useBodyweight;
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowPrev() {
    exerciseDetails = exerciseDetails.copyWith(
      baseWeight: _baseWeight,
    );

    context.flow<ExerciseDetailsFlowStages>().update((prev) => ExerciseDetailsFlowStages.stage4);
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(exercisesCreateControllerProvider);

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
          ],
        ),
      ),
      body: SizedBox.expand(
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding( 
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.defaultPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Base Weight Setup',
                          style: context.textTheme.labelLarge,
                        ),
                        SizedBox(
                          height: AppLayout.defaultPadding,
                        ),
                        WeightInput(
                          label: 'Weight', 
                          hintText: 'Set Weight', 
                          onChanged: (value, unit) {
                            BaseWeightEntity baseWeight = new BaseWeightEntity(
                              weightKgs: unit == WeightUnits.kilograms ? value : 0.0,
                              weightLbs: unit == WeightUnits.pounds ? value : 0.0,
                              assisted: _assisted == Assisted.assisted ? true : false, 
                              bodyWeight: _bodyWeight == BodyWeight.useBodyweight ? true : false,  
                              createdAt: DateTimeX.current, 
                              updatedAt: DateTimeX.current
                            );

                            _baseWeight = ExerciseDetailsBaseWeight(baseWeight);
                          }, 
                          readOnly: false, 
                          initialUnit: _initialUnit,
                          initialWeight: _weight,
                        ),
                        SizedBox(
                          height: AppLayout.defaultPadding,
                        ),
                        FlexableRadioList<Assisted>(
                          items: Assisted.values.toList(), 
                          onSelected: (Enumeration<Enum>? value) {
                            _assisted = value as Assisted;

                            BaseWeightEntity baseWeight = new BaseWeightEntity(
                              weightKgs: _baseWeight!.value.getOrElse((l) => null)!.weightKgs,
                              weightLbs: _baseWeight!.value.getOrElse((l) => null)!.weightLbs,
                              assisted: _assisted == Assisted.assisted ? true : false, 
                              bodyWeight: _bodyWeight == BodyWeight.useBodyweight ? true : false,  
                              createdAt: DateTimeX.current, 
                              updatedAt: DateTimeX.current
                            );

                            _baseWeight = ExerciseDetailsBaseWeight(baseWeight);
                          },
                          selectedValue: _assisted,
                          labelText: 'Assisted Exercise',
                          description: 'Assisted exercises logged weight will be subtracted from the base weight. Ex: Assisted Pull Ups'
                        ),
                        SizedBox(
                          height: AppLayout.defaultPadding,
                        ),
                        FlexableRadioList<BodyWeight>(
                          items: BodyWeight.values.toList(),
                          onSelected: (Enumeration<Enum>? value) {
                            _bodyWeight = value as BodyWeight;

                            BaseWeightEntity baseWeight = new BaseWeightEntity(
                              weightKgs: _baseWeight!.value.getOrElse((l) => null)!.weightKgs,
                              weightLbs: _baseWeight!.value.getOrElse((l) => null)!.weightLbs,
                              assisted: _assisted == Assisted.assisted ? true : false,
                              bodyWeight: _bodyWeight == BodyWeight.useBodyweight ? true : false,
                              createdAt: DateTimeX.current,
                              updatedAt: DateTimeX.current,
                            );

                            _baseWeight = ExerciseDetailsBaseWeight(baseWeight);
                          },
                          selectedValue: _bodyWeight,
                          labelText: 'Autofill Body Weight',
                          description: 'Select whether the weight should autofill to your most up to date bodyweight',
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
