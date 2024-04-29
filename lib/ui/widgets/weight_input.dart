import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/enums.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

double MIN_WEIGHT_KGS = -4535.47;
double MAX_WEIGHT_KGS = 4535.47;

double MIN_WEIGHT_LBS = -9999;
double MAX_WEIGHT_LBS = 9999;

class WeightInput extends StatefulWidget {
  WeightInput({
    required this.label,
    required this.hintText,
    required this.onChanged,
    required this.readOnly,
    required this.initialUnit,
    super.key,
    this.initialWeight,
    this.autoFocus,
  });

  /// Label
  final String label;

  /// Hint Text
  final String hintText;

  /// Initial Values
  final double? initialWeight;
  final WeightUnits initialUnit;

  /// On Changed
  final void Function(double, WeightUnits) onChanged;

  /// Read Only
  final bool readOnly;

  /// Auto Focus
  final bool? autoFocus;

  @override
  State<WeightInput> createState() => _WeightInputState();
}

class _WeightInputState extends State<WeightInput> {
  /// Weight Input
  late double _weight;

  /// Selected Weight Unit
  late WeightUnits _selectedUnit;

  /// Controller
  final _controller = new TextEditingController();

  /// Validator
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value == '-') {
      return null;
    } else if (value == '.') {
      value = '0.';
      _controller.text = value;
      return null;
    } else if (value == '-.') {
      value = '-0.';
      _controller.text = value;
      return null;
    }

    var v = double.parse(value);

    if (_selectedUnit == WeightUnits.kilograms) {
      if (v < MIN_WEIGHT_KGS || v > MAX_WEIGHT_KGS) {
        return 'Must be between ${MIN_WEIGHT_KGS} - ${MAX_WEIGHT_KGS} kgs.';
      }
    } else {
      if (v < MIN_WEIGHT_LBS || v > MAX_WEIGHT_LBS) {
        return 'Must be between ${MIN_WEIGHT_LBS} - ${MAX_WEIGHT_LBS} lbs.';
      }
    }

    return null;
  }

  @override
  void initState() {
    _weight = widget.initialWeight ?? 0.0;
    _selectedUnit = widget.initialUnit;
    _controller.text = _weight != 0.0 ? _weight.toString() : '';
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// On Weight Text Input Change
    void _onWeightChange(String? value) {
      setState(() {
        if(value == null || value!.isEmpty) {
          _weight = 0.0;

          widget.onChanged(_weight, _selectedUnit);
          return;
        }

        if (value == '-') {
          return;
        } else if (value == '.') {
          value = '0.';
        } else if (value == '-.') {
          value = '-0.';
        }

        _weight = double.parse(value!);

        widget.onChanged(_weight, _selectedUnit);
      });
    }

    /// On Weight Unit Change
    void _onWeightUnitChange(WeightUnits unit) {
      setState(() {
        _selectedUnit = unit;

        widget.onChanged(_weight, _selectedUnit);
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
              width: MediaQuery.of(context).size.width * 0.625,
              child: TextFormField(
                controller:  _controller,
                onChanged: _onWeightChange,
                validator: validator,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\-?\d*\.?\d*$')),
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
                  if (_selectedUnit == WeightUnits.kilograms) {
                    _onWeightUnitChange(WeightUnits.pounds);
                  } else {
                    _onWeightUnitChange(WeightUnits.kilograms);
                  }
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
                      Container(
                        height: 25,
                        width: 25,
                        child: Image(
                          image: AssetImage('assets/icons/weight_units/${_selectedUnit.name}.100x100.png'),
                          fit: BoxFit.scaleDown,
                        ),
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
    scrollControlDisabledMaxHeightRatio: 0.25,
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
          leading: Container(
            height: 27,
            width: 27,
            child: Image(
              image: AssetImage('assets/icons/${currentItem.name}.100x100.png'),
              fit: BoxFit.scaleDown,
            )
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
  );
}