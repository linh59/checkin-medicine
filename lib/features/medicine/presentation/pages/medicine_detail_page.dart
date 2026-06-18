import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/medicine_provider.dart';

import '../widgets/medicine_detail/loading_view.dart';
import '../widgets/medicine_detail/medicine_bottom_actions.dart';
import '../widgets/medicine_detail/medicine_header.dart';
import '../widgets/medicine_detail/medicine_tab_bar.dart';

import '../widgets/medicine_detail/overview_tab.dart';
import '../widgets/medicine_detail/ingredients_tab.dart';
import '../widgets/medicine_detail/warning_tab.dart';

class MedicineDetailPage extends ConsumerStatefulWidget {
  final String slug;
  final bool? isAddedMedicine;
  final String? notes;

  const MedicineDetailPage({
    super.key,
    required this.slug,
    this.isAddedMedicine,
    this.notes,
  });

  @override
  ConsumerState<MedicineDetailPage> createState() => _MedicineDetailPageState();
}

class _MedicineDetailPageState extends ConsumerState<MedicineDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final colorScheme = Theme.of(context).colorScheme;

    final medicineAsync = ref.watch(medicineDetailProvider(widget.slug));

    return medicineAsync.when(
      loading: () => const Scaffold(body: LoadingView()),

      error: (e, _) => Scaffold(
        appBar: AppBar(leading: const BackButton(), title: Text(t.notFound)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(e.toString(), textAlign: TextAlign.center),
          ),
        ),
      ),

      data: (medicine) {
        if (medicine == null) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: Text(t.medicineNotFound),
            ),
            body: Center(child: Text(t.medicineNotFound)),
          );
        }

        return Scaffold(
          backgroundColor: colorScheme.surfaceContainerLowest,

          body: SafeArea(
            top: false,

            child: NestedScrollView(
              physics: const BouncingScrollPhysics(),

              headerSliverBuilder: (_, __) => [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: false,

                  elevation: 0,
                  scrolledUnderElevation: 0,

                  backgroundColor: colorScheme.surface,

                  surfaceTintColor: Colors.transparent,

                  leading: const BackButton(),

                  title: Text(
                    medicine.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // actions: const [
                  //   Padding(
                  //     padding: EdgeInsets.only(right: 12),
                  //     child: ProfileSwitcher(),
                  //   ),
                  // ],
                ),
              ],

              body: Column(
                children: [
                  /// TOP CONTENT
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: MedicineHeader(
                          medicine: medicine,
                          notes: widget.notes,
                        ),
                      ),

                      MedicineTabBar(controller: _tabController),
                    ],
                  ),

                  /// TAB CONTENT
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,

                      physics: const BouncingScrollPhysics(),

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: OverviewTab(medicine: medicine),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: IngredientsTab(
                            ingredients: medicine.ingredients,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: WarningsTab(medicine: medicine),
                        ),
                      ],
                    ),
                  ),

                  /// BOTTOM ACTION
                  widget.isAddedMedicine == true
                      ? SizedBox()
                      : SafeArea(
                          top: false,

                          minimum: const EdgeInsets.fromLTRB(16, 12, 16, 12),

                          child: BottomAction(medicine: medicine),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
