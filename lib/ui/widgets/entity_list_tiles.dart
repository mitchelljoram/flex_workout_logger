import 'package:dotted_border/dotted_border.dart';
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/exercise_details.entity.dart';
import 'package:flex_workout_logger/features/workouts/domain/entities/set.entity.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

/// A selectable set tile
class SetListTile extends StatelessWidget {
  ///
  SetListTile({
    required this.set,
    required this.index,
    super.key,
  });

  /// Set the tile represents
  final SetEntity set;

  final int index;

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
          Container(
            child: InkWell(
              onTap: () {},
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
          ),
          SizedBox(
            width: AppLayout.defaultPadding,
          ),
          Container(
            child: InkWell(
              onTap: () {},
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
          ),
          SizedBox(
            width: AppLayout.defaultPadding,
          ),
          Container(
            child: InkWell(
              onTap: () {
              },
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
