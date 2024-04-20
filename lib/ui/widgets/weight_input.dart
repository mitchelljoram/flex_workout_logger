import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeightInput extends StatefulWidget {
  WeightInput({
    required this.label,
    required this.hintText,
    required this.onChanged,
    required this.readOnly,
    super.key,
    this.autoFocus,
    this.initialKgs,
    this.initialLbs,
  });

  /// Label
  final String label;

  /// Hint Text
  final String hintText;

  /// Initial Values
  final double? initialKgs;
  final double? initialLbs;

  /// On Changed
  final void Function(List<double>) onChanged;

  /// Read Only
  final bool readOnly;

  /// Auto Focus
  final bool? autoFocus;

  @override
  State<WeightInput> createState() => _WeightInputState();
}

class _WeightInputState extends State<WeightInput> {
  /// Weight Text Input
  List<double> _weight = [0.0, 0.0];

  /// Selected Weight Unit
  WeightUnits _selectedUnit = WeightUnits.pounds;

  /// Controllers
  final _controllerKgs = new TextEditingController();
  final _controllerLbs = new TextEditingController();

  /// Validator
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if(value == '.') {
      return 'Must have number before the decimal.';
    }

    var v = double.parse(value);

    if (_selectedUnit == WeightUnits.pounds) {
      if (v > 9999 || v < -9999) {
        return 'Must be between -9999 - 9999 lbs.';
      }
    } else {
      if (v > 4535.47 || v < -4535.47) {
        return 'Must be between -4535.47 - 4535.47 kgs.';
      }
    }

    return null;
  }

  @override
  void initState() {
    _weight = [widget.initialKgs ?? 0.0, widget.initialLbs ?? 0.0];
    _controllerKgs.text = _weight[WeightUnits.kilograms.index].toString();
    _controllerLbs.text = _weight[WeightUnits.pounds.index].toString();
    super.initState();
  }

  @override
  dispose() {
    _controllerKgs.dispose();
    _controllerLbs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// On Weight Text Input Change
    void _onWeightChange(String? value) {
      setState(() {
        if(value == null || value.isEmpty) {
          _weight[WeightUnits.kilograms.index] = 0.0;
          _weight[WeightUnits.pounds.index] = 0.0;

          _controllerKgs.text = '';
          _controllerLbs.text = '';

          return;
        }

        if (_selectedUnit == WeightUnits.pounds){
          _weight[WeightUnits.pounds.index] = double.parse(value);
          _weight[WeightUnits.kilograms.index] = double.parse((_weight[WeightUnits.pounds.index] / 2.205).toStringAsFixed(1));
          _controllerLbs.text = value;
          _controllerKgs.text = _weight[WeightUnits.kilograms.index].toString();
        } else {
          _weight[WeightUnits.kilograms.index] = double.parse(value);
          _weight[WeightUnits.pounds.index] = double.parse((_weight[WeightUnits.kilograms.index] * 2.205).toStringAsFixed(1));
          _controllerLbs.text = _weight[WeightUnits.pounds.index].toString();
          _controllerKgs.text = value;
        }
      });

      widget.onChanged(_weight);
    }

    /// On Weight Unit Change
    void _onWeightUnitChange(WeightUnits unit) {
      setState(() {
        _selectedUnit = unit;
      });
    }

    return Column(
      children: [
        Row(
          children: [
            Text(widget.label, style: context.textTheme.labelMedium),
            Spacer(),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextFormField(
                controller: _selectedUnit == WeightUnits.kilograms ? _controllerKgs : _controllerLbs,
                onChanged: _onWeightChange,
                validator: validator,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                ],
                readOnly: widget.readOnly,
                autofocus: widget.autoFocus ?? false,
                maxLines: 1,
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: widget.hintText,
                  hintMaxLines: 1,
                  hintStyle: context.textTheme.bodyMedium.copyWith(
                    color: context.colorScheme.foregroundSecondary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: context.colorScheme.backgroundTertiary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border style when the field is focused
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: context.colorScheme.foregroundPrimary,
                      width: 2,
                    ),
                  ), // Enable filling of the text field
                  contentPadding: const EdgeInsets.all(AppLayout.smallPadding),
                ),
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: TextButton(
                onPressed: () async {
                  var res = await _showWeightUnitBottomSheet(
                    context,
                  );

                  if (res == null) return;

                  _onWeightUnitChange(res);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero, // Set minimum size to zero
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.colorScheme.backgroundTertiary,
                  ),
                  child: Row(
                    children: [
                      Text(
                        _selectedUnit.name,
                        style: context.textTheme.bodyMedium.copyWith(
                          color: context.colorScheme.foregroundPrimary,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        CupertinoIcons.chevron_down,
                        color: context.colorScheme.foregroundSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

Future<WeightUnits?> _showWeightUnitBottomSheet<String>(
  BuildContext context,
) {
  List<WeightUnits> units = WeightUnits.values.toList();

  return showModalBottomSheet(
    context: context, 
    showDragHandle: true,
    elevation: 0,
    constraints: BoxConstraints(
      minWidth: double.infinity,           
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => ListView.separated(
      itemCount: units.length,
      separatorBuilder: (context, index) => Divider(
        color: context.colorScheme.divider,
        height: 1,
        indent: 64,
      ),
      itemBuilder: (context, index) {
        final currentItem = units[index];

        return CupertinoListTile(
          title: Text(
            currentItem.name,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelLarge.copyWith(
              color: context.colorScheme.foregroundPrimary,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop(currentItem);
          },
          padding: const EdgeInsets.fromLTRB(
            20,
            16,
            14,
            16,
          ),
        );
      },
    ),
  );
}