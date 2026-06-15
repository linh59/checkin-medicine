import 'dart:async';

import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/medicines_management/presentation/pages/create_medicine_page.dart';
import 'package:checkin_medicine/features/search/presentation/widgets/medicine_card.dart';
import 'package:checkin_medicine/features/search/presentation/widgets/search_ai_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/search_provider.dart';

import '../widgets/medicine_tab_bar.dart';
import '../widgets/search_input.dart';

import '../widgets/nutrient_result_card.dart';
import '../widgets/empty_state.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  Timer? debounce;

  String query = '';
  String debouncedQuery = '';

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void onSearchChanged(String value) {
    query = value;

    debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          debouncedQuery = value.trim();
        });
      }
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final medicines = ref.watch(medicineSearchProvider(debouncedQuery));
    final nutrients = ref.watch(nutrientSearchProvider(debouncedQuery));
    return Scaffold(
      appBar: AppBar(
        title: Text(t.searchTitle),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.medication_outlined),
            label: Text(t.createMedicine),
            onPressed: () async {
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (_) => const CreateMedicinePage()),
              );

              if (result == true) {
                ref.invalidate(medicineSearchProvider(debouncedQuery));
              }
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            SearchInput(hint: t.searchHint, onChanged: onSearchChanged),

            const SizedBox(height: 16),

            // SearchAiSection(query: query),
            SearchTabBar(controller: tabController),

            const SizedBox(height: 12),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  medicines.when(
                    data: (list) => list.isEmpty
                        ? EmptyState(title: t.noResults, query: query)
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (_, i) {
                              return MedicineResultCard(item: list[i]);
                            },
                          ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text(e.toString())),
                  ),

                  nutrients.when(
                    data: (list) => list.isEmpty
                        ? EmptyState(title: t.noResults, query: query)
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (_, i) {
                              return NutrientResultCard(item: list[i]);
                            },
                          ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text(e.toString())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
