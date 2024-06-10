
import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

class BubbleLabel extends StatelessWidget{

  BubbleLabel({
    required this.label,
    required this.backgroundColor,
  });

  final String label;

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      child: Container(
        color: context.colorScheme.backgroundTertiary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.smallPadding,
          vertical: AppLayout.extraMiniPadding,
        ),
        child: Text(
          label,
          style: context.textTheme.labelMedium.copyWith(
            color: context.colorScheme.foregroundPrimary,
          ),
        ),
      ),
    );
  }
}

class BubbleIconLabel extends StatelessWidget{

  BubbleIconLabel({
    required this.label,
    required this.backgroundColor,
    required this.icon,
  });

  final String label;

  final Color backgroundColor;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.only(
                right: AppLayout.miniPadding,
              ),
              child: Icon(
                icon,
                size: 12,
              ),
            ),
            Text(
              label,
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

class BubbleImageLabel extends StatelessWidget{

  BubbleImageLabel({
    required this.label,
    required this.backgroundColor,
    required this.image,
  });

  final String label;

  final Color backgroundColor;

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.smallPadding,
          vertical: AppLayout.extraMiniPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: AppLayout.miniPadding,
              ),
              child: ImageIcon(
                AssetImage('assets/icons/${image}'),
                size: 12,
              ),
            ),  
            Text(
              label,
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

class BubbleIconButton extends StatelessWidget{

  BubbleIconButton({
    required this.label,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
  });

  final String label;

  final Color backgroundColor;

  final IconData icon;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.smallPadding,
          vertical: AppLayout.extraMiniPadding,
        ),
        child: InkWell(
          onTap: onTap,
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
                  icon,
                  size: 12,
                  color: context.colorScheme.foregroundPrimary,
                ),
                const SizedBox(
                  width: AppLayout.smallPadding,
                ),
                Text(
                  label,
                  style: context.textTheme.bodySmall.copyWith(
                    color: context.colorScheme.foregroundPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}