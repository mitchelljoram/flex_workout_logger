import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/ui/containers/exercises_list.dart';
import 'package:flex_workout_logger/ui/widgets/library_segment_controller.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Library screen
class LibraryScreen extends StatefulWidget {
  /// Constructor
  const LibraryScreen({super.key});

  /// Route name
  static const routeName = 'library';

  /// Path name
  static const routePath = 'library';

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  int _selectedLibrary = 1;

  void _onLibraryChanged(int index) {
    setState(() {
      _selectedLibrary = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: CustomScrollView(
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Library',
              style: TextStyle(color: context.colorScheme.foreground),
            ),
            backgroundColor: context.colorScheme.offBackground,
            border: null,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppLayout.defaultPadding,
                vertical: AppLayout.smallPadding,
              ),
              child: Row(
                
                children: [
                  Container(
                    width: 300,
                    child: LibrarySegementedController(
                      selectedValue: _selectedLibrary, 
                      onValueChanged: _onLibraryChanged,
                    ),
                  ),
                  // TODO: change this spacer
                  Spacer(),
                  IconButton.filled(
                    icon: const Icon(CupertinoIcons.add),
                    iconSize: 20,
                    style: IconButton.styleFrom(
                      backgroundColor: context.colorScheme.muted,
                      foregroundColor: context.colorScheme.foreground,
                    ),
                    onPressed: () => {
                      // if (_selectedLibrary == 1) {
                      //   context.goNamed(
                      //     ProgramCreateScreen.routeName,
                      //   ),
                      // } else if (_selectedLibrary == 2) {
                      //   context.goNamed(
                      //     WorkoutCreateScreen.routeName,
                      //   ),
                      // } else {
                      //   context.goNamed(
                      //     ExercisesCreateScreen.routeName,
                      //   ),
                      // }
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: ExercisesList()),
        ],
      ),
    );
  }
}