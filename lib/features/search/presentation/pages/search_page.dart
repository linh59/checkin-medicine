import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../medicine/presentation/pages/medicine_detail_page.dart';
import '../providers/search_provider.dart';

class SearchPage
    extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage>
  createState() =>
      _SearchPageState();
}

class _SearchPageState
    extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  Timer? debounce;

  String query = '';
  String debouncedQuery = '';

  @override
  void initState() {
    super.initState();

    tabController =
        TabController(length: 2, vsync: this);
  }

  void onSearchChanged(
      String value,
      ) {
    query = value;

    debounce?.cancel();

    debounce = Timer(
      const Duration(milliseconds: 350),
          () {
        if (mounted) {
          setState(() {
            debouncedQuery =
                value.trim();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    debounce?.cancel();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t =
    AppLocalizations.of(context)!;

    final medicines = ref.watch(
      medicineSearchProvider(
        debouncedQuery,
      ),
    );

    final nutrients = ref.watch(
      nutrientSearchProvider(
        debouncedQuery,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(t.searchTitle),
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged:
              onSearchChanged,
              decoration:
              InputDecoration(
                hintText:
                t.searchHint,
                prefixIcon:
                const Icon(
                  Icons.search,
                ),
              ),
            ),

            const SizedBox(height: 16),

            TabBar(
              controller:
              tabController,
              tabs: [
                Tab(
                  text:
                  t.medicines,
                ),
                Tab(
                  text:
                  t.nutrients,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Expanded(
              child: TabBarView(
                controller:
                tabController,
                children: [
                  medicines.when(
                    data: (list) =>
                        ListView.builder(
                          itemCount:
                          list.length,
                          itemBuilder:
                              (
                              context,
                              index,
                              ) {
                            final item =
                            list[index];

                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(16),
                                side: BorderSide(
                                  color:
                                  Theme.of(context)
                                      .dividerColor,
                                ),
                              ),
                              child: ListTile(
                                contentPadding:
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),

                                leading: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: WellnessColors
                                        .primary
                                        .withOpacity(0.12),
                                    borderRadius:
                                    BorderRadius.circular(
                                      14,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.medication,
                                    color:
                                    WellnessColors.primary,
                                  ),
                                ),

                                title: Text(
                                  item.brand,
                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),

                                subtitle: Text(
                                  item.genericName ?? '',
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),

                                trailing: const Icon(
                                  Icons.chevron_right,
                                ),

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          MedicineDetailPage(
                                            slug: item.slug,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                    loading:
                        () =>
                    const Center(
                      child:
                      CircularProgressIndicator(),
                    ),
                    error:
                        (
                        e,
                        _,
                        ) =>
                        Center(
                          child:
                          Text(
                            e.toString(),
                          ),
                        ),
                  ),

                  nutrients.when(
                    data: (list) =>
                        ListView.builder(
                          itemCount:
                          list.length,
                          itemBuilder:
                              (
                              context,
                              index,
                              ) {
                            final item =
                            list[index];

                            return Card(
                              child:
                              ListTile(
                                leading:
                                const Icon(
                                  Icons
                                      .science,
                                  color:
                                  WellnessColors.primary,
                                ),
                                title:
                                Text(
                                  item.name,
                                ),
                                subtitle:
                                Text(
                                  item.summary ??
                                      '',
                                ),
                              ),
                            );
                          },
                        ),
                    loading:
                        () =>
                    const Center(
                      child:
                      CircularProgressIndicator(),
                    ),
                    error:
                        (
                        e,
                        _,
                        ) =>
                        Center(
                          child:
                          Text(
                            e.toString(),
                          ),
                        ),
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