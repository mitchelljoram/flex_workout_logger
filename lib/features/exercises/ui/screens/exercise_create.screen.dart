import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/exercises_view.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/base_exercise.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/description.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/icon.validation.dart';
import 'package:flex_workout_logger/features/exercises/domain/validations/exercise_details/name.validation.dart';
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
      backgroundColor: context.colorScheme.backgroundPrimary,
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
          SizedBox.expand(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: AppLayout.defaultPadding,
                vertical: AppLayout.extraLargePadding,
              ),
              child: ExerciseDetailsFlow(),
            ),
          ),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     padding: const EdgeInsets.only(
          //       left: AppLayout.smallPadding,
          //       right: AppLayout.smallPadding,
          //       top: AppLayout.miniPadding,
          //     ),
          //     color: context.colorScheme.offBackground,
          //     child: const StepIndicator(currentStep: 1, totalSteps: 3),
          //   ),
          // ),
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlowBuilder(
      state: ExerciseDetails(
        icon: ExerciseDetailsIcon('exercise.100x100.png'),
        baseExercise: ExerciseDetailsBaseExercise(null,null),
        name: ExerciseDetailsName(''),
        description: ExerciseDetailsDescription(''),
      ),
      onGeneratePages: onGeneratePages
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

class ExerciseDetailsCreateFormPage1 extends StatefulWidget {
  @override
  _ExerciseDetailsCreateFormPage1State createState() => _ExerciseDetailsCreateFormPage1State();
}

class _ExerciseDetailsCreateFormPage1State extends State<ExerciseDetailsCreateFormPage1> {
  final _formKey = GlobalKey<FormState>();

  ExerciseDetailsIcon? _icon;
  ExerciseDetailsBaseExercise? _baseExercise;
  ExerciseDetailsName? _name;
  ExerciseDetailsDescription? _description;

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

  int selectedVariation = 1;

  void _onVariationChanged(int index) {
    setState(() {
      if (index == 1) {
        _baseExercise = ExerciseDetailsBaseExercise(null, null);
      }
      selectedVariation = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [],
      )
    );
  }
}