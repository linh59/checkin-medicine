import 'package:checkin_medicine/features/medicine/presentation/pages/medicine_detail_page.dart';
import 'package:checkin_medicine/features/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/my_medicine_provider.dart';
import '../widgets/empty_state_medicine.dart';
import '../widgets/my_medicine_card.dart';
import 'package:checkin_medicine/shared/widgets/profile_switcher.dart';

class MyMedicinesPage extends ConsumerWidget {
  const MyMedicinesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicines = ref.watch(myMedicinesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myMedicineCabinet),

        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 12),
        //     child: ProfileSwitcher(),
        //   ),
        // ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchPage()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(myMedicinesProvider);

          await ref.read(myMedicinesProvider.future);
        },
        child: medicines.when(
          loading: () => const Center(child: CircularProgressIndicator()),

          error: (e, _) => Center(child: Text(e.toString())),

          data: (items) {
            if (items.isEmpty) {
              return const EmptyMyMedicine();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),

              itemCount: items.length,

              separatorBuilder: (_, __) => const SizedBox(height: 12),

              itemBuilder: (_, index) {
                final item = items[index];

                return MyMedicineCard(
                  medicine: item,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MedicineDetailPage(
                          slug: item.medicine!.slug,
                          isAddedMedicine: true,
                          notes: item.notes,
                        ),
                      ),
                    );
                  },

                  onDelete: () async {
                    if (!item.canDelete) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.medicineUsedInTimeline,
                            ),
                          ),
                        );
                      }

                      return;
                    }

                    await ref
                        .read(myMedicineRepositoryProvider)
                        .deleteMedicine(item);

                    ref.invalidate(myMedicinesProvider);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
