import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/controllers/theme_controller.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ThemeController>();

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _item(
            context,
            icon: Icons.light_mode,
            active: !controller.isDark,
            onTap: controller.setLight,
          ),
          const SizedBox(width: 6),
          _item(
            context,
            icon: Icons.dark_mode,
            active: controller.isDark,
            onTap: controller.setDark,
          ),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context, {
        required IconData icon,
        required bool active,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active
              ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 20,
          color: active
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
      ),
    );
  }
}