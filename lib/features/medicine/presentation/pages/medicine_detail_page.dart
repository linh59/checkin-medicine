import 'package:checkin_medicine/features/medicine/presentation/widgets/medicine_detail/medicine_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/medicine_provider.dart';
import '../widgets/medicine_detail/loading_view.dart';
import '../widgets/medicine_detail/medicine_bottom_actions.dart';
import '../widgets/medicine_detail/medicine_header.dart';
import '../widgets/medicine_detail/overview_tab.dart';
import '../widgets/medicine_detail/ingredients_tab.dart';
import '../widgets/medicine_detail/warning_tab.dart';

class MedicineDetailPage extends ConsumerStatefulWidget {
  final String slug;

  const MedicineDetailPage({
    super.key,
    required this.slug,
  });

  @override
  ConsumerState<MedicineDetailPage> createState() =>
      _MedicineDetailPageState();
}

class _MedicineDetailPageState
    extends ConsumerState<MedicineDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final medicineAsync = ref.watch(
      medicineDetailProvider(widget.slug),
    );

    return medicineAsync.when(
      loading: () => const Scaffold(
        body: LoadingView(),
      ),

      error: (e, _) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(t.notFound),
        ),
        body: Center(
          child: Text(e.toString()),
        ),
      ),

      data: (medicine) {
        if (medicine == null) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: Text(t.notFound),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(t.notFound),

                    const SizedBox(height: 12),

                    Text(
                      t.medicineNotFound,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        t.backToSearch,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (_, __) {
              return [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: false,
                  elevation: 0,
                  scrolledUnderElevation: 0,

                  backgroundColor:
                  Theme.of(context)
                      .scaffoldBackgroundColor,

                  leading:
                  const BackButton(),

                  title: Text(
                    medicine.brand,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                  ),
                ),
              ];
            },

            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                    const EdgeInsets.all(
                      16,
                    ),
                    child: Column(
                      children: [
                        MedicineHeader(
                          medicine:
                          medicine,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        MedicineTabBar(
                          controller:
                          _tabController,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height:
                          MediaQuery.of(
                            context,
                          )
                              .size
                              .height *
                              0.65,
                          child:
                          TabBarView(
                            controller:
                            _tabController,
                            children: [
                              OverviewTab(
                                medicine:
                                medicine,
                              ),
                              IngredientsTab(
                                medicine:
                                medicine,
                              ),
                              WarningsTab(
                                medicine:
                                medicine,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                BottomAction(
                  medicine: medicine,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
