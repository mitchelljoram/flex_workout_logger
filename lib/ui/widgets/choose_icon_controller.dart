import 'package:dotted_border/dotted_border.dart';
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseIconController extends StatefulWidget {
  final FormFieldValidator? validator;
  final void Function(String) onChanged;
  final String? initialIcon;

  const ChooseIconController({
    required this.validator,
    required this.onChanged,
    this.initialIcon,
    super.key,
  });

  @override
  State<ChooseIconController> createState() => _ChooseIconControllerState();
}

class _ChooseIconControllerState extends State<ChooseIconController> {

  String _pickedIcon = '';
  String _pickedColor = 'primary';

  @override
  void initState() {
    _pickedIcon = widget.initialIcon ?? '';
    _pickedColor = _pickedIcon != '' ? _pickedIcon.split('.')[1] : 'primary';
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _icons = [
      'exercise.primary.100x100.png',
    ];

    final Map<String, Color> _colors = {
      'primary' : context.colorScheme.foregroundPrimary,
      'pink' : context.colorScheme.pink,
      'purple' : context.colorScheme.purple,
      'blue' : context.colorScheme.blue,
      'green' : context.colorScheme.green,
      'yellow' : context.colorScheme.yellow,
      'orange' : context.colorScheme.orange,
    };

    void _onIconChanged(String value) {
      setState(() {
        if (_pickedColor != 'primary') {
          final i = value.split('.primary.100x100.png');
          _pickedIcon = '${i[0]}.${_pickedColor}.100x100.png';
        }
        else {
          _pickedIcon = value;
        }

        widget.onChanged(_pickedIcon);
      });
    }

    void _onColorChanged(String value) {
      setState(() {
        _pickedColor = value;

        final i = _pickedIcon != '' ? _pickedIcon.split('.') : null;
        if(i != null && i[1] != _pickedColor) {
          _pickedIcon = '${i[0]}.${_pickedColor}.100x100.png';
        }

        widget.onChanged(_pickedIcon);
      });
    }

    return DottedBorder(
      borderType: BorderType.Circle,
      dashPattern: const [3, 5],
      color: _colors[_pickedColor]!,
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: InkWell(
              onTap:() async {
                var res = await _showIconBottomSheet(context, _icons);

                if (res == null) return;

                _onIconChanged(res);
              },
              customBorder: const CircleBorder(),
              child: Align(
                alignment: Alignment.center,
                child: _pickedIcon != '' ?
                  Container(
                    height: 40,
                    width: 40,
                    child: Image(
                      image: AssetImage('assets/icons/${_pickedIcon}'),
                      fit: BoxFit.scaleDown,
                    )
                  ) :
                  Text(
                    'Icon',
                    style: context.textTheme.headlineLarge,
                  ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 220,
            child: IconButton(
              onPressed: () async {
                var res = await _showColorBottomSheet(context, _colors);

                if (res == null) return;

                _onColorChanged(res);
              },
              style: IconButton.styleFrom(
                backgroundColor: context.colorScheme.backgroundTertiary,
              ),
              icon: Icon( 
                CupertinoIcons.paintbrush,
                color: _colors[_pickedColor],
                size: 20,
              ),
            )
          ),
        ],
      )
    );
  }
}

Future<String?> _showIconBottomSheet<String>(
  BuildContext context,
  List<String> icons,
) {
  return showModalBottomSheet(
    context: context, 
    showDragHandle: true,
    scrollControlDisabledMaxHeightRatio: 0.9,
    elevation: 0,
    constraints: BoxConstraints(
      minWidth: double.infinity,           
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (context) => Wrap(
      children: icons.map((i) => IconButton(
          onPressed: () {
            Navigator.of(context).pop(i);
          },
          icon: ImageIcon(
            AssetImage('assets/icons/${i}'),
            size: 27,
          ),
        )
      ).toList(),
    )
  );
}

Future<String?> _showColorBottomSheet<String>(
  BuildContext context,
  Map<String, Color> colors,
) {
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
    builder: (context) => Wrap(
      children: colors.keys.map((c) => Padding(
        padding: EdgeInsets.only(
          left: AppLayout.defaultPadding,
          right: AppLayout.defaultPadding,
          bottom: AppLayout.defaultPadding
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop(c);
          },
          style: IconButton.styleFrom(
            backgroundColor: colors[c],
          ),
          icon: Text(''),
        ),
      )).toList(),
    )
  );
}