import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SearchTabBar extends StatelessWidget {
  final TabController controller;

  const SearchTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / 2;

          return AnimatedBuilder(
            animation: controller.animation!,
            builder: (context, _) {
              final animationValue = controller.animation!.value;
              final activeIndex = animationValue.round();

              return Stack(
                children: [
                  /// INDICATOR
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    left: animationValue * tabWidth,
                    child: Container(
                      width: tabWidth,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withOpacity(0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// TABS
                  Row(
                    children: [
                      _TabItem(
                        label: t.medicines,
                        isActive: activeIndex == 0,
                        onTap: () => controller.animateTo(0),
                      ),
                      _TabItem(
                        label: t.nutrients,
                        isActive: activeIndex == 1,
                        onTap: () => controller.animateTo(1),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 44,
          alignment: Alignment.center,

          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,

            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,

              color: isActive ? Colors.white : colorScheme.onSurfaceVariant,
            ),

            child: Text(label),
          ),
        ),
      ),
    );
  }
}
