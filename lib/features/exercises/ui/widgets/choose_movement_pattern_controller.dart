import 'package:dotted_border/dotted_border.dart';
import 'package:flex_workout_logger/features/exercises/controllers/movement_pattern_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/movement_pattern.entity.dart';
import 'package:flex_workout_logger/ui/widgets/entity_selection_sheet.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseMovementPatternController extends ConsumerWidget {
  final FormFieldValidator? validator;
  final void Function(MovementPatternEntity) onChanged;

  const ChooseMovementPatternController({
    required this.validator,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movementPatterns = ref.watch(movementPatternListControllerProvider);

    return EntitySelectionSheet<MovementPatternEntity>(
      validator: validator,
      hintText: 'Select a movement pattern',
      labelText: 'Movement Pattern',
      onChanged: onChanged,
      isRequired: true,
      items: movementPatterns.asData?.value
        .map(
          (mp) => DropdownMenuItem(
            value: mp,
            child: CupertinoListTile(
              title: Text(
                mp.name,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelLarge.copyWith(
                  color: context.colorScheme.foregroundPrimary,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop(mp);
              },
              leading: Container(
                height: 27,
                width: 27,
                child: mp.icon.isNotEmpty ?
                  Image(
                    image: AssetImage('assets/icons/${mp.icon}'),
                    fit: BoxFit.scaleDown,
                  ) :
                  DottedBorder(
                    borderType: BorderType.Circle,
                    dashPattern: const [3, 5],
                    color: context.colorScheme.foregroundPrimary,
                    child: Container()
                  )
              ),
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                14,
                16,
              ),
            ),
          ),
        )
        .toList() ??
      [],
    );
  }
}