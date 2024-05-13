import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/muscle_group.entity.dart';
import 'package:flex_workout_logger/features/exercises/ui/widgets/front_back_segment_controller.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MuscleGroupsTargeted extends StatefulWidget {
  /// Constructor
  MuscleGroupsTargeted({
    required this.primaryTargeted,
    required this.secondaryTargeted,
    super.key,
  });

  /// Primary Muscle Groups Targeted
  final List<MuscleGroupEntity> primaryTargeted;

  /// Secondary Muscle Groups Targeted
  final List<MuscleGroupEntity> secondaryTargeted;

  State<MuscleGroupsTargeted> createState() => _MuscleGroupsTargetedState();
}

class _MuscleGroupsTargetedState extends State<MuscleGroupsTargeted> {

  late int _selectedView;

  @override
  void initState() {
    _selectedView = 1;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onViewChanged(int index) {
    setState(() {
      _selectedView = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.backgroundSecondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppLayout.defaultPadding,
        horizontal: AppLayout.defaultPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Muscle Groups Targeted',
            style: context.textTheme.bodyMedium.copyWith(
              color: context.colorScheme.foregroundPrimary,
            ),
          ),
          SizedBox(
            height: AppLayout.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IndexedStack(
                index: _selectedView - 1,
                children: [
                  _frontView(context),
                  _backView(context),
                ],
              ),
              SizedBox(
                width: AppLayout.defaultPadding,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: context.colorScheme.pink,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(999),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppLayout.extraMiniPadding,
                      ),
                      Text(
                        'Primary',
                        style: context.textTheme.labelSmall.copyWith(
                          color: context.colorScheme.foregroundPrimary,
                        ),
                      ),
                    ],
                  ),
                  if (widget.primaryTargeted.length > 0)
                    Container(
                      width: 195,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: AppLayout.extraMiniPadding
                        ),
                        child: Wrap(
                          spacing: AppLayout.miniPadding,
                          runSpacing: AppLayout.miniPadding,
                          children: [
                            ...widget.primaryTargeted.map((pmg) => 
                              _bubble(
                                context,
                                pmg.name,
                                null
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: AppLayout.defaultPadding,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: context.colorScheme.pink.withOpacity(0.3),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(999),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppLayout.extraMiniPadding,
                      ),
                      Text(
                        'Secondary',
                        style: context.textTheme.labelSmall.copyWith(
                          color: context.colorScheme.foregroundPrimary,
                        ),
                      ),
                    ],
                  ),
                  if (widget.secondaryTargeted.length > 0)
                    Container(
                      width: 195,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: AppLayout.extraMiniPadding
                        ),
                        child: Wrap(
                          spacing: AppLayout.miniPadding,
                          runSpacing: AppLayout.miniPadding,
                          children: [
                            ...widget.secondaryTargeted.map((smg) => 
                              _bubble(
                                context,
                                smg.name,
                                null
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
          SizedBox(
            height: AppLayout.defaultPadding,
          ),
          Align(
            alignment: Alignment.center,
            child: FrontBackSegementedController(
              selectedValue: _selectedView,
              onValueChanged: _onViewChanged,
            ),
          ),
        ],
      )
    );
  }

  Widget _frontView(
    BuildContext context,
  ) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/muscle_groups/front.svg',
          colorFilter: ColorFilter.mode(context.colorScheme.foregroundQuaternary, BlendMode.srcIn),
          height: 240,
        ),
        ...widget.primaryTargeted.map((pmg) =>
          SvgPicture.asset(
            'assets/muscle_groups/front/${pmg.icon}',
            colorFilter: ColorFilter.mode(context.colorScheme.pink, BlendMode.srcIn),
            height: 240,
          )
        ),
        ...widget.secondaryTargeted.map((smg) =>
          SvgPicture.asset(
            'assets/muscle_groups/front/${smg.icon}',
            colorFilter: ColorFilter.mode(context.colorScheme.pink.withOpacity(0.3), BlendMode.srcIn),
            height: 240,
          )
        ),
      ],
    );
  }

  Widget _backView(
    BuildContext context,
  ) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/muscle_groups/back.svg',
          colorFilter: ColorFilter.mode(context.colorScheme.foregroundQuaternary, BlendMode.srcIn),
          height: 240,
        ),
        ...widget.primaryTargeted.map((pmg) =>
          SvgPicture.asset(
            'assets/muscle_groups/back/${pmg.icon}',
            colorFilter: ColorFilter.mode(context.colorScheme.pink, BlendMode.srcIn),
            height: 240,
          )
        ),
        ...widget.secondaryTargeted.map((smg) =>
          SvgPicture.asset(
            'assets/muscle_groups/back/${smg.icon}',
            colorFilter: ColorFilter.mode(context.colorScheme.pink.withOpacity(0.3), BlendMode.srcIn),
            height: 240,
          )
        ),
      ],
    );
  }

  Widget _bubble(BuildContext context, String text, String? icon) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      child: Container(
        color: context.colorScheme.backgroundTertiary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.smallPadding,
          vertical: AppLayout.extraMiniPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && icon.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  right: AppLayout.miniPadding,
                ),
                child: ImageIcon(
                  AssetImage('assets/icons/${icon}'),
                  size: 12,
                ),
              ),
            Text(
              text,
              style: context.textTheme.labelMedium.copyWith(
                color: context.colorScheme.foregroundPrimary,
              ),
            ),
          ],
        )
      ),
    );
  }
}