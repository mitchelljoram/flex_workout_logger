import 'package:dotted_border/dotted_border.dart';
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/set.entity.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Exercise Details Entity List Tiles

/// A muscle group tile with options
class MuscleGroupListTile extends StatelessWidget {
  ///
  MuscleGroupListTile({
    required this.muscleGroup,
    required this.iconPath,
    required this.detailsOnTap,
    required this.removeOnTap,
    super.key,
  });

  /// Muscle group the tile represents
  final MuscleGroupEntity muscleGroup;

  final String iconPath;

  final void Function() detailsOnTap;

  final void Function() removeOnTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        muscleGroup.name,
        style: context.textTheme.labelLarge.copyWith(
          color: context.colorScheme.foregroundPrimary,
        ),
      ),
      subtitle: Row(
        children: [
          DetailsButton(detailsOnTap: detailsOnTap),
          SizedBox(
            width: AppLayout.defaultPadding,
          ),
          RemoveButton(removeOnTap: removeOnTap)
        ],
      ),
      leading: Container(
        width: 24,
        height: 24,
        child: SvgPicture.asset(
          iconPath,
          fit: BoxFit.contain
        ),
      ),
      padding: EdgeInsets.zero,
    );
  }
}

/// A selectable exercise tile
class ExerciseListTile extends StatelessWidget {
  ///
  const ExerciseListTile({
    required this.exercise,
    this.onTap,
    this.trailingIcon,
    super.key,
  });

  /// Exercise the tile represents
  final ExerciseDetailsEntity exercise;

  /// On tap callback
  final void Function()? onTap;

  /// Trailing Icon
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        exercise.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.labelLarge.copyWith(
          color: context.colorScheme.foregroundPrimary,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          if (exercise.movementPattern != null || exercise.baseExercise != null)
            Text(
              exercise.baseExercise != null
                  ? '${exercise.baseExercise!.name} Variation'
                  : exercise.movementPattern?.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium.copyWith(
                color: context.colorScheme.foregroundSecondary,
              ),
            ),
          if (exercise.movementPattern != null || exercise.baseExercise != null)
            const SizedBox(width: AppLayout.defaultPadding),
          if (exercise.primaryMuscleGroups.isNotEmpty)
            Expanded(
              child: Text(
                exercise.primaryMuscleGroups.map((e) => e.name).join(' • ') + (exercise.secondaryMuscleGroups.isNotEmpty ? (' • ') + exercise.secondaryMuscleGroups.map((e) => e.name).join(' • ') : ''),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelMedium.copyWith(
                  color: context.colorScheme.foregroundSecondary,
                ),
              ),
            ),
        ],
      ),
      onTap: onTap,
      leading: Container(
        height: 27,
        width: 27,
        child: exercise.icon.isNotEmpty ?
          Image(
            image: AssetImage('assets/icons/exercises/${exercise.icon}'),
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


/// Workout Entity List Tiles

/// A set tile with options
class SetListTile extends StatelessWidget {
  ///
  SetListTile({
    required this.set,
    required this.index,
    required this.editOnTap,
    required this.duplicateOnTap,
    required this.removeOnTap,
    super.key,
  });

  /// Set the tile represents
  final SetEntity set;

  final int index;

  final void Function() editOnTap;

  final void Function() duplicateOnTap;

  final void Function() removeOnTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            set.type.name,
            style: context.textTheme.labelLarge.copyWith(
              color: context.colorScheme.foregroundPrimary,
            ),
          ),
          Row(
            children: [
              Text(
                set.minIntensity == set.maxIntensity ? '${set.minIntensity} %1RM' : '${set.minIntensity}-${set.maxIntensity} %1RM',
                style: context.textTheme.bodySmall.copyWith(
                  color: context.colorScheme.foregroundSecondary,
                ),
              ),
              SizedBox(
                width: AppLayout.defaultPadding,
              ),
              Text(
                set.exertionRPE.toString(),
                style: context.textTheme.bodySmall.copyWith(
                  color: context.colorScheme.foregroundSecondary,
                ),
              ),
              SizedBox(
                width: AppLayout.defaultPadding,
              ),
              Text(
                set.minRestTime == set.maxRestTime ? '${set.minRestTime} ${set.restUnits} rest' : '${set.minRestTime}-${set.maxRestTime} ${set.restUnits} rest',
                style: context.textTheme.bodySmall.copyWith(
                  color: context.colorScheme.foregroundSecondary,
                ),
              ),
            ],
          )
        ],
      ),
      subtitle: Row(
        children: [
          SizedBox(
            width: AppLayout.extraLargePadding,
          ),
          EditButton(
            editOnTap: editOnTap
          ),
          SizedBox(
            width: AppLayout.defaultPadding,
          ),
          DuplicateButton(
            duplicateOnTap: duplicateOnTap
          ),
          SizedBox(
            width: AppLayout.defaultPadding,
          ),
          RemoveButton(
            removeOnTap: removeOnTap
          )
        ],
      ),
      leading: Text(
        index.toString(),
        style: context.textTheme.headlineLarge.copyWith(
          color: context.colorScheme.foregroundSecondary,
        ),
      ),
      trailing: Column(
        children: [
          Text(
            set.minNumberReps == set.maxNumberReps ? set.minNumberReps.toString() : '${set.minNumberReps}-${set.maxNumberReps}',
            style: context.textTheme.labelLarge.copyWith(
              color: context.colorScheme.foregroundPrimary,
            ),
          ),
          Text(
            'Reps',
            style: context.textTheme.labelXSmall.copyWith(
              color: context.colorScheme.foregroundSecondary,
            ),
          ),
        ],
      ),
    );
  }
}


/// Tile Option Buttons

/// Details
class DetailsButton extends StatelessWidget{
  ///
  const DetailsButton({
    required this.detailsOnTap,
    super.key
  });

  final void Function() detailsOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: detailsOnTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.info_circle,
              size: 16
            ),
            SizedBox(
              width: AppLayout.extraMiniPadding,
            ),
            Text(
              'Details',
              style: context.textTheme.labelSmall.copyWith(
                color: context.colorScheme.foregroundPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Edit
class EditButton extends StatelessWidget{
  ///
  const EditButton({
    required this.editOnTap,
    super.key
  });

  final void Function() editOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: editOnTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.pencil,
              size: 16
            ),
            SizedBox(
              width: AppLayout.extraMiniPadding,
            ),
            Text(
              'Edit',
              style: context.textTheme.labelSmall.copyWith(
                color: context.colorScheme.foregroundPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Duplicate
class DuplicateButton extends StatelessWidget{
  ///
  const DuplicateButton({
    required this.duplicateOnTap,
    super.key
  });

  final void Function() duplicateOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: duplicateOnTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.square_on_square,
              size: 16
            ),
            SizedBox(
              width: AppLayout.extraMiniPadding,
            ),
            Text(
              'Duplicate',
              style: context.textTheme.labelSmall.copyWith(
                color: context.colorScheme.foregroundPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Remove
class RemoveButton extends StatelessWidget{
  ///
  const RemoveButton({
    required this.removeOnTap,
    super.key
  });

  final void Function() removeOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: removeOnTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.minus_circle,
              size: 16,
              color: Color.fromRGBO(242, 184, 181, 1),
            ),
            SizedBox(
              width: AppLayout.extraMiniPadding,
            ),
            Text(
              'Remove',
              style: context.textTheme.labelSmall.copyWith(
                color: context.colorScheme.foregroundPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}