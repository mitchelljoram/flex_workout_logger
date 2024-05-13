import 'dart:io';

import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/controllers/muscle_group_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/autofill_segment_controller.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ChooseMuscleGroupsController extends ConsumerStatefulWidget {
  final void Function(List<MuscleGroupEntity>, List<MuscleGroupEntity>) onChanged;
  final List<MuscleGroupEntity> initialPrimaryMuscleGroups;
  final List<MuscleGroupEntity> initialSeconadryMuscleGroups;
  final MovementPatternEntity? movementPattern;

  const ChooseMuscleGroupsController({
    required this.onChanged,
    required this.initialPrimaryMuscleGroups,
    required this.initialSeconadryMuscleGroups,
    required this.movementPattern,
    super.key,
  });

  @override
  ConsumerState<ChooseMuscleGroupsController> createState() => _ChooseMuscleGroupsControllerState();
}

class _ChooseMuscleGroupsControllerState extends ConsumerState<ChooseMuscleGroupsController> {

  List<MuscleGroupEntity> _primaryMuscleGroups = [];
  List<MuscleGroupEntity> _secondaryMuscleGroups = [];
  MovementPatternEntity? _movementPattern;

  @override
  void initState() {
    _primaryMuscleGroups = widget.initialPrimaryMuscleGroups;
    _secondaryMuscleGroups = widget.initialSeconadryMuscleGroups;
    _movementPattern = widget.movementPattern;
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  void _onAutofillChanged(int index) {
    setState(() {
      if (index == 2) {
        _primaryMuscleGroups = _movementPattern!.primaryMuscleGroups;
        _secondaryMuscleGroups = _movementPattern!.secondaryMuscleGroups;
      }
    });
  }

  void _onPrimaryChanged(List<MuscleGroupEntity> newPrimaryMuscleGroups) {
    setState(() {
      _primaryMuscleGroups = newPrimaryMuscleGroups;
    });
  }

  void _onSecondaryChanged(List<MuscleGroupEntity> newSecondaryMuscleGroups) {
    setState(() {
      _secondaryMuscleGroups = newSecondaryMuscleGroups;
    });
  }

  @override
  Widget build(BuildContext context) {
    final muscleGroups = ref.watch(muscleGroupListControllerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Autofill muscle groups based on the movement pattern?',
          style: context.textTheme.headlineMedium,
        ),
        const SizedBox(height: AppLayout.smallPadding),
        AutofillSegementedController(
          selectedValue: 1,
          onValueChanged: _onAutofillChanged,
        ),
        const SizedBox(height: AppLayout.defaultPadding),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/muscle_groups/front.svg',
                    colorFilter: ColorFilter.mode(context.colorScheme.foregroundQuaternary, BlendMode.srcIn),
                    height: 240,
                  ),
                  ..._primaryMuscleGroups.map((pmg) =>
                    SvgPicture.asset(
                      'assets/muscle_groups/front/${pmg.icon}',
                      colorFilter: ColorFilter.mode(context.colorScheme.pink, BlendMode.srcIn),
                      height: 240,
                    )
                  ),
                  ..._secondaryMuscleGroups.map((smg) =>
                    SvgPicture.asset(
                      'assets/muscle_groups/front/${smg.icon}',
                      colorFilter: ColorFilter.mode(context.colorScheme.pink.withOpacity(0.3), BlendMode.srcIn),
                      height: 240,
                    )
                  ),
                ],
              ),
              const SizedBox(width: AppLayout.largePadding),
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/muscle_groups/back.svg',
                    colorFilter: ColorFilter.mode(context.colorScheme.foregroundQuaternary, BlendMode.srcIn),
                    height: 240,
                  ),
                  ..._primaryMuscleGroups.map((pmg) =>
                    SvgPicture.asset(
                      'assets/muscle_groups/back/${pmg.icon}',
                      colorFilter: ColorFilter.mode(context.colorScheme.pink, BlendMode.srcIn),
                      height: 240,
                    )
                  ),
                  ..._secondaryMuscleGroups.map((smg) =>
                    SvgPicture.asset(
                      'assets/muscle_groups/back/${smg.icon}',
                      colorFilter: ColorFilter.mode(context.colorScheme.pink.withOpacity(0.3), BlendMode.srcIn),
                      height: 240,
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.defaultPadding),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Primary Muscle Groups',
                style: context.textTheme.labelMedium.copyWith(
                  color: context.colorScheme.foregroundPrimary,
                ),
              ),
              ..._primaryMuscleGroups.map((pmg) =>
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppLayout.smallPadding,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(
                            'assets/icons/muscle_groups/primary/${pmg.icon}',
                            fit: BoxFit.contain
                          ),
                        ),
                        SizedBox(
                          width: AppLayout.miniPadding,
                        ),
                        Text(
                          pmg.name,
                          style: context.textTheme.labelLarge.copyWith(
                            color: context.colorScheme.foregroundPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppLayout.smallPadding,
                    ),
                    Row(
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
                        ),
                        SizedBox(
                          width: AppLayout.defaultPadding,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              final newPrimaryMuscleGroups = _primaryMuscleGroups;
                              newPrimaryMuscleGroups.remove(pmg);

                              _onPrimaryChanged(newPrimaryMuscleGroups);
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
                    Divider(
                      indent: AppLayout.extraLargePadding,
                    ),
                  ],
                )
              ),
              SizedBox(
                height: AppLayout.smallPadding,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.backgroundTertiary,
                  borderRadius: BorderRadius.circular(999)
                ),
                child: InkWell(
                  onTap:() async {
                    var res = await _showPrimaryBottomSheet(
                      context, 
                      muscleGroups.value!,
                      _primaryMuscleGroups,
                      _secondaryMuscleGroups
                    );

                    _onPrimaryChanged(res);
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.extraMiniPadding
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.add,
                          size: 12,
                          color: context.colorScheme.foregroundPrimary,
                        ),
                        const SizedBox(
                          width: AppLayout.smallPadding,
                        ),
                        Text(
                          'Add Muscle Groups',
                          style: context.textTheme.bodySmall.copyWith(
                            color: context.colorScheme.foregroundPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.defaultPadding),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Secondary Muscle Groups',
                style: context.textTheme.labelMedium.copyWith(
                  color: context.colorScheme.foregroundPrimary,
                ),
              ),
              SizedBox(
                height: AppLayout.smallPadding,
              ),
              ..._secondaryMuscleGroups.map((smg) =>
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppLayout.smallPadding,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(
                            'assets/icons/muscle_groups/secondary/${smg.icon}',
                            fit: BoxFit.contain
                          ),
                        ),
                        SizedBox(
                          width: AppLayout.miniPadding,
                        ),
                        Text(
                          smg.name,
                          style: context.textTheme.labelLarge.copyWith(
                            color: context.colorScheme.foregroundPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppLayout.smallPadding,
                    ),
                    Row(
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
                        ),
                        SizedBox(
                          width: AppLayout.defaultPadding,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              final newSecondaryMuscleGroups = _secondaryMuscleGroups;
                              newSecondaryMuscleGroups.remove(smg);

                              _onSecondaryChanged(newSecondaryMuscleGroups);
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
                    Divider(
                      indent: AppLayout.extraLargePadding,
                    ),
                  ],
                )
              ),
              SizedBox(
                height: AppLayout.smallPadding,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.backgroundTertiary,
                  borderRadius: BorderRadius.circular(999)
                ),
                child: InkWell(
                  onTap:() async {
                    var res = await _showSecondaryBottomSheet(
                      context, 
                      muscleGroups.value!,
                      _primaryMuscleGroups,
                      _secondaryMuscleGroups
                    );

                    _onSecondaryChanged(res);
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppLayout.defaultPadding,
                      vertical: AppLayout.extraMiniPadding
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.add,
                          size: 12,
                          color: context.colorScheme.foregroundPrimary,
                        ),
                        const SizedBox(
                          width: AppLayout.smallPadding,
                        ),
                        Text(
                          'Add Muscle Groups',
                          style: context.textTheme.bodySmall.copyWith(
                            color: context.colorScheme.foregroundPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<List<MuscleGroupEntity>> _showPrimaryBottomSheet(
  BuildContext context,
  List<MuscleGroupEntity> muscleGroups,
  List<MuscleGroupEntity> primary,
  List<MuscleGroupEntity> secondary,
) async {
  final _items = muscleGroups;
  final _primary = primary;
  final _secondary = secondary;

  await showModalBottomSheet<List<MuscleGroupEntity>>(
    context: context,
    scrollControlDisabledMaxHeightRatio: 1,
    useSafeArea: true,
    showDragHandle: false,
    backgroundColor: context.colorScheme.backgroundPrimary,
    barrierColor: context.colorScheme.backgroundPrimary,
    elevation: 0,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row for selected items
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.backgroundPrimary,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppLayout.miniPadding,
                  horizontal: AppLayout.miniPadding,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.backgroundSecondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(999),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Selected items
                      ..._primary.map(
                        (p) => Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: context.colorScheme.foregroundPrimary,
                                shape: BoxShape.circle,
                              ),
                              padding:
                                  const EdgeInsets.all(AppLayout.smallPadding),
                              child: Container(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset(
                                  'assets/icons/muscle_groups/primary/${p.icon}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox( 
                              width: AppLayout.smallPadding,
                            )
                          ]
                        ),
                      ),
                      const Spacer(),
                    ]
                  ),
                ),
              ),
              // Divider
              Container(
                height: kMinInteractiveDimension,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.backgroundSecondary,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Center(
                  child: Container(
                    height: 4,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32 / 2),
                      color: context.colorScheme.foregroundPrimary.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: context.colorScheme.backgroundSecondary,
                  child: ListView.separated(
                    padding:
                        EdgeInsets.only(bottom: Platform.isAndroid ? 110 : 64),
                    itemCount: _items.length,
                    separatorBuilder: (context, index) => Divider(
                      color: context.colorScheme.divider,
                      height: 1,
                      indent: 64,
                    ),
                    itemBuilder: (context, index) {
                      final currentItem = _items[index];

                      return CupertinoListTile(
                        title: Text(
                          currentItem.name,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelLarge.copyWith(
                            color: context.colorScheme.foregroundPrimary,
                          ),
                        ),
                        subtitle: _secondary.contains(currentItem) ?
                          Padding(
                            padding: EdgeInsets.only(
                              right: AppLayout.largePadding,
                            ),
                            child: Text(
                              'In secondary muscle groups',
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelSmall.copyWith(
                                color: context.colorScheme.foregroundSecondary,
                              ),
                            ),
                          ) :
                          null,
                        onTap: () {
                          if (_secondary.contains(currentItem)) {
                            return;
                          }

                          if (_primary.contains(currentItem)){
                            setState(() {
                              _primary.remove(currentItem);
                            });
                            return;
                          }

                          if (_primary.length >= 5) {
                            return;
                          }

                          setState(() {
                            _primary.add(currentItem);
                          });
                        },
                        leading: Container(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(
                            'assets/icons/muscle_groups/primary/${currentItem.icon}',
                            fit: BoxFit.contain,
                          ),
                        ),
                        trailing: _primary.contains(currentItem) || _secondary.contains(currentItem)
                          ? const Padding(
                              padding: EdgeInsets.only(
                                  left: AppLayout.miniPadding),
                              child: Icon(
                                CupertinoIcons.check_mark_circled_solid,
                                size: 16,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(
                                  left: AppLayout.miniPadding),
                              child: Icon(
                                CupertinoIcons.add_circled,
                                size: 16,
                              ),
                            ),
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          16,
                          14,
                          16,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  return _primary;
}

Future<List<MuscleGroupEntity>> _showSecondaryBottomSheet(
  BuildContext context,
  List<MuscleGroupEntity> muscleGroups,
  List<MuscleGroupEntity> primary,
  List<MuscleGroupEntity> secondary,
) async {
  final _items = muscleGroups;
  final _primary = primary;
  final _secondary = secondary;

  await showModalBottomSheet<List<MuscleGroupEntity>>(
    context: context,
    scrollControlDisabledMaxHeightRatio: 1,
    useSafeArea: true,
    showDragHandle: false,
    backgroundColor: context.colorScheme.backgroundPrimary,
    barrierColor: context.colorScheme.backgroundPrimary,
    elevation: 0,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row for selected items
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.backgroundPrimary,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppLayout.miniPadding,
                  horizontal: AppLayout.miniPadding,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.backgroundSecondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(999),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Selected items
                      ..._secondary.map(
                        (s) => Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: context.colorScheme.foregroundPrimary,
                                shape: BoxShape.circle,
                              ),
                              padding:
                                  const EdgeInsets.all(AppLayout.smallPadding),
                              child: Container(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset(
                                  'assets/icons/muscle_groups/secondary/${s.icon}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox( 
                              width: AppLayout.smallPadding,
                            )
                          ]
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              // Divider
              Container(
                height: kMinInteractiveDimension,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.backgroundSecondary,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Center(
                  child: Container(
                    height: 4,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32 / 2),
                      color: context.colorScheme.foregroundPrimary.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: context.colorScheme.backgroundSecondary,
                  child: ListView.separated(
                    padding:
                        EdgeInsets.only(bottom: Platform.isAndroid ? 110 : 64),
                    itemCount: _items.length,
                    separatorBuilder: (context, index) => Divider(
                      color: context.colorScheme.divider,
                      height: 1,
                      indent: 64,
                    ),
                    itemBuilder: (context, index) {
                      final currentItem = _items[index];

                      return CupertinoListTile(
                        title: Text(
                          currentItem.name,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelLarge.copyWith(
                            color: context.colorScheme.foregroundPrimary,
                          ),
                        ),
                        subtitle: _primary.contains(currentItem) ?
                          Padding(
                            padding: EdgeInsets.only(
                              right: AppLayout.largePadding,
                            ),
                            child: Text(
                              'In primary muscle groups',
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelSmall.copyWith(
                                color: context.colorScheme.foregroundSecondary,
                              ),
                            ),
                          ) :
                          null,
                        onTap: () {
                          if (_primary.contains(currentItem)) {
                            return;
                          }

                          if (_secondary.contains(currentItem)){
                            setState(() {
                              _secondary.remove(currentItem);
                            });
                            return;
                          }

                          if (_secondary.length >= 5) {
                            return;
                          }

                          setState(() {
                            _secondary.add(currentItem);
                          });
                        },
                        leading: Container(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(
                            'assets/icons/muscle_groups/secondary/${currentItem.icon}',
                            fit: BoxFit.contain,
                          ),
                        ),
                        trailing: _primary.contains(currentItem) || _secondary.contains(currentItem)
                          ? const Padding(
                              padding: EdgeInsets.only(
                                  left: AppLayout.miniPadding),
                              child: Icon(
                                CupertinoIcons.check_mark_circled_solid,
                                size: 16,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(
                                  left: AppLayout.miniPadding),
                              child: Icon(
                                CupertinoIcons.add_circled,
                                size: 16,
                              ),
                            ),
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          16,
                          14,
                          16,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  return _secondary;
}
