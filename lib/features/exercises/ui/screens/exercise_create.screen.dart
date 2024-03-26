import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_create.controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/engagement.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/equipment.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/movement_pattern.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/name.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/type.validation.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/choose_base_exercise_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/choose_equipment_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/choose_movement_pattern_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/radio_list_controller.dart';
import 'package:flex_workout_logger/ui/widgets/choose_icon_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/variation_segment_controller.dart';
import 'package:flex_workout_logger/ui/widgets/flexable_textfield.dart';
import 'package:flex_workout_logger/ui/widgets/step_indicator.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Exercises Detail Create Screen
class ExerciseCreateScreen extends StatelessWidget {
  /// Constructor
  const ExerciseCreateScreen({super.key});

  /// Route name
  static const routeName = 'exercises_create';

  /// Path name where eid is the id of the exercise
  static const routePath = 'exercises/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.backgroundSecondary,
      appBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: context.colorScheme.backgroundSecondary,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(
            CupertinoIcons.xmark,
          ),
          color: context.colorScheme.foregroundPrimary,
          iconSize: 24,
        ),
        middle: Text(
          'Create Exercise',
          style: TextStyle(color: context.colorScheme.foregroundPrimary),
        ),
      ),
      body: ExerciseDetailsFlow()
    );
  }
}

class ExerciseDetails {
  final ExerciseDetailsIcon icon;
  final ExerciseDetailsBaseExercise baseExercise;
  final ExerciseDetailsName name;
  final ExerciseDetailsDescription description;
  final ExerciseDetailsMovementPattern movementPattern;
  final ExerciseDetailsEquipment? equipment;
  final ExerciseDetailsEngagement engagement;
  final ExerciseDetailsType type;
  // final ExerciseDetailsMuscleGroups primaryMuscleGroups;
  // final ExerciseDetailsMuscleGroups secondaryMuscleGroups;
  // final ExerciseDetailsBaseWeight? baseWeight;
  // final ExerciseDetailsPersonalRecord? personalRecord;

  const ExerciseDetails({
    required this.icon,
    required this.baseExercise,
    required this.name,
    required this.description,
    required this.movementPattern,
    this.equipment,
    required this.engagement,
    required this.type,
    // required this.primaryMuscleGroups,
    // required this.secondaryMuscleGroups,
    // this.baseWeight,
    // this.personalRecord,
  });

  ExerciseDetails copyWith({
    ExerciseDetailsIcon? icon,
    ExerciseDetailsBaseExercise? baseExercise,
    ExerciseDetailsName? name,
    ExerciseDetailsDescription? description,
    ExerciseDetailsMovementPattern? movementPattern,
    ExerciseDetailsEquipment? equipment,
    ExerciseDetailsEngagement? engagement,
    ExerciseDetailsType? type,
  }) {
    return ExerciseDetails(
      icon: icon ?? this.icon,
      baseExercise: baseExercise ?? this.baseExercise,
      name: name ?? this.name,
      description: description ?? this.description,
      movementPattern: movementPattern ?? this.movementPattern,
      equipment: equipment ?? this.equipment,
      engagement: engagement ?? this.engagement,
      type: type ?? this.type,
    );
  }
}

ExerciseDetails newExercise = ExerciseDetails(
  icon: ExerciseDetailsIcon(''),
  baseExercise: ExerciseDetailsBaseExercise(null, null),
  name: ExerciseDetailsName(''),
  description: ExerciseDetailsDescription(''),
  movementPattern: ExerciseDetailsMovementPattern(null),
  equipment: ExerciseDetailsEquipment(null),
  engagement: ExerciseDetailsEngagement(Engagement.bilateral),
  type: ExerciseDetailsType(ExerciseType.repitition),
);

const int TOTAL_STEPS = 4;

enum CreateExerciseStages {stage1, stage2, stage3, stage4}

List<Page> onGeneratePages(
  CreateExerciseStages stage, 
  List<Page> pages,
) {
  switch(stage) {
    case CreateExerciseStages.stage1: 
      return [ExerciseDetailsCreateFormPage1.page()];
    case CreateExerciseStages.stage2: 
      return [ExerciseDetailsCreateFormPage2.page()];
    case CreateExerciseStages.stage3: 
    //  return [ExerciseDetailsCreateFormPage3.page()];
    case CreateExerciseStages.stage4: 
    //  return [ExerciseDetailsCreateFormPage4.page()];
    default: 
      return [ExerciseDetailsCreateFormPage1.page()];
  }
}

class ExerciseDetailsFlow extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<ExerciseDetailsEntity?>>(exercisesCreateControllerProvider,
        (previous, next) {
      next.maybeWhen(
        data: (data) {
          if (data == null) return;

          ref.read(exercisesListControllerProvider.notifier).addExercise(data);
          context.pop();
        },
        orElse: () {},
      );
    });

    newExercise = new ExerciseDetails(
      icon: ExerciseDetailsIcon(''),
      baseExercise: ExerciseDetailsBaseExercise(null,null),
      name: ExerciseDetailsName(''),
      description: ExerciseDetailsDescription(''),
      movementPattern: ExerciseDetailsMovementPattern(null),
      equipment: ExerciseDetailsEquipment(null),
      engagement: ExerciseDetailsEngagement(Engagement.bilateral),
      type: ExerciseDetailsType(ExerciseType.repitition)
    );

    return FlowBuilder<CreateExerciseStages>(
      state: CreateExerciseStages.stage1,
      onGeneratePages: onGeneratePages,
      // onComplete: ,
    );
  }
}

class ExerciseDetailsCreateFormPage1 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: ExerciseDetailsCreateFormPage1());

  @override
  ConsumerState<ExerciseDetailsCreateFormPage1> createState() => _ExerciseDetailsCreateFormPage1State();
}

class _ExerciseDetailsCreateFormPage1State extends ConsumerState<ExerciseDetailsCreateFormPage1> {
  final _formKey = GlobalKey<FormState>();

  ExerciseDetailsIcon? _icon;
  ExerciseDetailsBaseExercise? _baseExercise;
  ExerciseDetailsName? _name;
  ExerciseDetailsDescription? _description;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  late int _selectedVariation;

  @override
  void initState() {
    if (newExercise.icon.value.isRight()) {
      _icon = newExercise.icon;
    }
    if (newExercise.baseExercise.value.isRight()) {
      if (newExercise.baseExercise.value.getOrElse((l) => null) != null){
        _selectedVariation = 2;
      } else {
        _selectedVariation = 1;
      }

      _baseExercise = newExercise.baseExercise;
    }
    if (newExercise.name.value.isRight()) {
      _nameController.text = newExercise.name.value.getOrElse((l) => '');
      _name = newExercise.name;
    }
    if (newExercise.description.value.isRight()) {
      _descriptionController.text = newExercise.description.value.getOrElse((l) => '');
      _description = newExercise.description;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowNext() {
    newExercise = newExercise.copyWith(
      icon: _icon,
      baseExercise: _baseExercise,
      name: _name,
      description: _description,
    );

    context.flow<CreateExerciseStages>().update((next) => CreateExerciseStages.stage2);
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

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Stack(
        children: [
          Padding(
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
                      
                      if(_baseExercise!.value.isRight()) {
                        _icon = _icon ?? ExerciseDetailsIcon(_baseExercise!.value.getOrElse((l) => null)!.icon);
                      
                        final n = _baseExercise!.value.getOrElse((l) => null)!.name;
                        _nameController.text = _name?.value.getOrElse((l) => '') ?? '${n} Variation';
                        _name = _name ?? ExerciseDetailsName('${n} Variation');

                        final d = _baseExercise!.value.getOrElse((l) => null)!.description;
                        _descriptionController.text = _description?.value.getOrElse((l) => '') ?? d;
                        _description = _description ?? ExerciseDetailsDescription(d);
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
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      onPressed: isLoading ?
                        null :
                        () {
                          if (!_formKey.currentState!.validate()) return;

                          if (_name!.value.isLeft()) return;

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
                )
              ],
            )
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
              child: const StepIndicator(currentStep: 1, totalSteps: TOTAL_STEPS),
            )
          ),
        ],
      )
    );
  }
}

class ExerciseDetailsCreateFormPage2 extends ConsumerStatefulWidget {
  static MaterialPage page() => MaterialPage(child: ExerciseDetailsCreateFormPage2());

  @override
  ConsumerState<ExerciseDetailsCreateFormPage2> createState() => _ExerciseDetailsCreateFormPage2State();
}

class _ExerciseDetailsCreateFormPage2State extends ConsumerState<ExerciseDetailsCreateFormPage2> {
  final _formKey = GlobalKey<FormState>();

  ExerciseDetailsMovementPattern? _movementPattern;
  ExerciseDetailsEquipment? _equipment;
  ExerciseDetailsEngagement? _engagement;
  ExerciseDetailsType? _type;

  @override
  void initState() {
    if (newExercise.movementPattern.value.isRight()) {
      _movementPattern = newExercise.movementPattern;
    }
    if (newExercise.equipment!.value.isRight()) {
      _equipment = newExercise.equipment;
    }
    if (newExercise.engagement.value.isRight()) {
      _engagement = newExercise.engagement;
    }
    if (newExercise.type.value.isRight()) {
      _type = newExercise.type;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleFlowNext() {
    newExercise = newExercise.copyWith(
      movementPattern: _movementPattern,
      equipment: _equipment,
      engagement: _engagement,
      type: _type,
    );

    context.flow<CreateExerciseStages>().update((next) => CreateExerciseStages.stage3);
  }

  void handleFlowPrev() {
    newExercise = newExercise.copyWith(
      movementPattern: _movementPattern,
      equipment: _equipment,
      engagement: _engagement,
      type: _type,
    );

    context.flow<CreateExerciseStages>().update((prev) => CreateExerciseStages.stage1);
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(exercisesCreateControllerProvider);

    final isLoading = res.maybeWhen(
      data: (_) => res.isRefreshing,
      loading: () => true,
      orElse: () => false,
    );

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Stack(
        children: [
          Padding(
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
                RadioListController<Engagement>(
                  items: Engagement.values.toList(), 
                  onSelected: (Enumeration<Enum>? value) => _engagement = ExerciseDetailsEngagement(value as Engagement), 
                  selectedValue: _engagement?.value.getOrElse((l) => Engagement.bilateral), 
                  labelText: 'Body Engagement',
                  description: 'How the body engages with the lift during the movement.',
                ),
                const SizedBox(
                  height: AppLayout.defaultPadding,
                ),
                RadioListController<ExerciseType>(
                  items: ExerciseType.values.toList(), 
                  onSelected: (Enumeration<Enum>? value) => _type = ExerciseDetailsType(value as ExerciseType),
                  selectedValue: _type?.value.getOrElse((l) => ExerciseType.repitition), 
                  labelText: 'Exercise Type',
                  description: 'How are you going to record your exercise.',
                ),
                Spacer(),
                Row(
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

                          if (_movementPattern!.value.isLeft()) return;

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
                )
              ]
            )
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
              child: const StepIndicator(currentStep: 2, totalSteps: TOTAL_STEPS),
            )
          ),
        ],
      )
    );
  }
}