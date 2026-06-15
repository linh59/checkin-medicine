import 'package:checkin_medicine/features/medicines_management/presentation/providers/admin_ingredient_forms_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IngredientFormDialog extends ConsumerStatefulWidget {
  final String nutrientId;

  const IngredientFormDialog({super.key, required this.nutrientId});

  @override
  ConsumerState<IngredientFormDialog> createState() =>
      _IngredientFormDialogState();
}

class _IngredientFormDialogState extends ConsumerState<IngredientFormDialog> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final formByNutrientId = ref.watch(
      adminIngredientFormsProvider(widget.nutrientId),
    );

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.ingredientForms,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: formByNutrientId.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),

                  error: (e, _) => Center(child: Text('${t.error}: $e')),

                  data: (forms) {
                    if (forms.isEmpty) {
                      return Center(child: Text(t.noIngredientFormsFound));
                    }

                    return ListView.separated(
                      itemCount: forms.length,

                      separatorBuilder: (_, __) => const Divider(height: 1),

                      itemBuilder: (context, index) {
                        final item = forms[index];

                        return ListTile(
                          title: Text(item.name),

                          subtitle: item.saltForm?.isNotEmpty == true
                              ? Text(item.saltForm!)
                              : null,

                          onTap: () {
                            Navigator.of(context).pop(item);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
