import 'package:dotted_border/dotted_border.dart';
import 'package:flex_workout_logger/features/exercises/controllers/equipment_list.controller.dart';
import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:flex_workout_logger/ui/widgets/entity_selection_sheet.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseEquipmentController extends ConsumerWidget {
  final FormFieldValidator? validator;
  final void Function(EquipmentEntity) onChanged;
  final EquipmentEntity? initialValue;

  const ChooseEquipmentController({
    required this.validator,
    required this.onChanged,
    required this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipment = ref.watch(equipmentListControllerProvider);

    return EntitySelectionSheet<EquipmentEntity>(
      validator: validator,
      hintText: 'Select the equipment used',
      labelText: 'Equipment',
      onChanged: onChanged,
      initialValue: initialValue,
      items: equipment.asData?.value
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: CupertinoListTile(
              title: Text(
                e.name,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelLarge.copyWith(
                  color: context.colorScheme.foregroundPrimary,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop(e);
              },
              leading: Container(
                height: 27,
                width: 27,
                child: e.icon.isNotEmpty ?
                  Image(
                    image: AssetImage('assets/icons/${e.icon}'),
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