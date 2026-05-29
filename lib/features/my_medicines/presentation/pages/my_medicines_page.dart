import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/my_medicine_provider.dart';
import '../widgets/empty_state_medicine.dart';
import '../widgets/my_medicine_card.dart';

class MyMedicinesPage
    extends ConsumerWidget {
  const MyMedicinesPage({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final medicines =
    ref.watch(
      myMedicinesProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(
            context,
          )!
              .myMedicineCabinet,
        ),
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: () {
          // go search
        },
        child: const Icon(
          Icons.add,
        ),
      ),

      body: medicines.when(
        loading: () =>
        const Center(
          child:
          CircularProgressIndicator(),
        ),

        error: (e, _) =>
            Center(
              child: Text(
                e.toString(),
              ),
            ),

        data: (items) {
          if (items.isEmpty) {
            return const EmptyMyMedicine();
          }

          return ListView.separated(
            padding:
            const EdgeInsets.all(
              16,
            ),
            itemCount:
            items.length,

            separatorBuilder:
                (_, __) =>
            const SizedBox(
              height: 12,
            ),

            itemBuilder:
                (_, index) {
              final item =
              items[index];

              return MyMedicineCard(
                medicine:
                item,

                onTap: () {},

                onDelete:
                    () async {
                  await ref
                      .read(
                    myMedicineRepositoryProvider,
                  )
                      .deleteMedicine(
                    item.id,
                  );

                  ref.invalidate(
                    myMedicinesProvider,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}