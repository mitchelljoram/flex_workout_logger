import 'package:flex_workout_logger/config/routing/error.screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercise_create.screen.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/exercise_view.screen.dart';
import 'package:flex_workout_logger/ui/screens/library.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main router for the Example app
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: LibraryScreen.routeName,
      builder: (context, state) => const LibraryScreen(),
      routes: [
        GoRoute(
          path: ExerciseCreateScreen.routePath,
          name: ExerciseCreateScreen.routeName,
          builder: (context, state) => const ExerciseCreateScreen(),
        ),
        GoRoute(
          path: ExerciseViewScreen.routePath,
          name: ExerciseViewScreen.routeName,
          builder: (context, state) => ExerciseViewScreen(
            id: state.pathParameters['eid']!,
          ),
        ),
        // GoRoute(
        //   path: ExercisesEditScreen.routePath,
        //   name: ExercisesEditScreen.routeName,
        //   builder: (context, state) => ExercisesEditScreen(
        //     id: state.pathParameters['eid']!,
        //   ),
        // ),
      ],
    ),
  ],
  observers: [
    routeObserver,
  ],
  debugLogDiagnostics: true,
  errorBuilder: (context, state) =>
      // ErrorScreen(message: context.tr.somethingWentWrong),
      ErrorScreen(message: 'Something went wrong.'),
);

/// Route observer to use with RouteAware
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
