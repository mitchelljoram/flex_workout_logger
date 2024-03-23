import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_create.controller.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/name.validation.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/choose_base_exercise_controller.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/variation_segment_controller.dart';
import 'package:flex_workout_logger/ui/widgets/flexable_textfield.dart';
import 'package:flex_workout_logger/ui/widgets/step_indicator.dart';
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
      body: Stack(
        children: <Widget>[
          ExerciseDetailsFlow(),
        ],
      ),
    );
  }
}

class ExerciseDetails {
  final ExerciseDetailsIcon icon;
  final ExerciseDetailsBaseExercise baseExercise;
  final ExerciseDetailsName name;
  final ExerciseDetailsDescription description;
  // final ExerciseDetailsMovementPattern? movementPattern;
  // final ExerciseDetailsEquipment? equipment;
  // final ExerciseDetailsEngagement engagement;
  // final ExerciseDetailsType type;
  // final ExerciseDetailsMuscleGroups primaryMuscleGroups;
  // final ExerciseDetailsMuscleGroups secondaryMuscleGroups;
  // final ExerciseDetailsBaseWeight? baseWeight;
  // final ExerciseDetailsPersonalRecord? personalRecord;

  const ExerciseDetails({
    required this.icon,
    required this.baseExercise,
    required this.name,
    required this.description,
    // this.movementPattern,
    // this.equipment,
    // required this.engagement,
    // required this.type,
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
  }) {
    return ExerciseDetails(
      icon: icon ?? this.icon,
      baseExercise: baseExercise ?? this.baseExercise,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}

class ExerciseDetailsFlow extends ConsumerWidget {
  static Route route() => MaterialPageRoute(builder: (_) => ExerciseDetailsFlow());

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

    return FlowBuilder(
      state: ExerciseDetails(
        icon: ExerciseDetailsIcon(''),
        baseExercise: ExerciseDetailsBaseExercise(null,null),
        name: ExerciseDetailsName(''),
        description: ExerciseDetailsDescription(''),
      ),
      onGeneratePages: onGeneratePages,
      // onComplete: ,
    );
  }
}

List<Page> onGeneratePages(ExerciseDetails exercise, List<Page> pages) {
  return [
    MaterialPage(child: ExerciseDetailsCreateFormPage1()),
    // MaterialPage(child: ExerciseDetailsCreateFormPage2()),
    // MaterialPage(child: ExerciseDetailsCreateFormPage3()),
    // MaterialPage(child: ExerciseDetailsCreateFormPage4()),
  ];
}

class ExerciseDetailsCreateFormPage1 extends ConsumerStatefulWidget {
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

  @override
  void initState() {
    super.initState();

    if (context.flow<ExerciseDetails>().state.icon.value.isRight()) {
      _icon = context.flow<ExerciseDetails>().state.icon;
    }
    if (context.flow<ExerciseDetails>().state.baseExercise.value.isRight()) {
      _baseExercise = context.flow<ExerciseDetails>().state.baseExercise;
    }
    if (context.flow<ExerciseDetails>().state.name.value.isRight()) {
      final n = context.flow<ExerciseDetails>().state.name.value.getOrElse((l) => '');
      _nameController.text = n;
      _name = ExerciseDetailsName(n);
    }
    if (context.flow<ExerciseDetails>().state.description.value.isRight()) {
      final d = context.flow<ExerciseDetails>().state.description.value.getOrElse((l) => '');
      _descriptionController.text = d;
      _description = ExerciseDetailsDescription(d);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void handleFlow() {
    context.flow<ExerciseDetails>().update((exercise) {
      return exercise.copyWith(
        icon: _icon,
        baseExercise: _baseExercise,
        name: _name,
        description: _description,
      );
    });
  }

  int _selectedVariation = 1;

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
      child: Column(
        children: [
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
              child: const StepIndicator(currentStep: 1, totalSteps: 4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppLayout.defaultPadding,
              vertical: AppLayout.largePadding,
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
                    }
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
              ],
            )
          ),
        ],
      ),
    );
  }
}