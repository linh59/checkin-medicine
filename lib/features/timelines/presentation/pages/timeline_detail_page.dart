import 'package:checkin_medicine/features/timelines/data/models/timeline_detail_model.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timeline_detail_provider.dart';
import 'package:checkin_medicine/features/timelines/presentation/widgets/detail/timeline_header_card.dart';
import 'package:checkin_medicine/features/timelines/presentation/widgets/detail/timeline_schedule_tab.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineDetailPage extends ConsumerStatefulWidget {
  final String timelineId;

  const TimelineDetailPage({super.key, required this.timelineId});

  @override
  ConsumerState<TimelineDetailPage> createState() => _TimelineDetailPageState();
}

class _TimelineDetailPageState extends ConsumerState<TimelineDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final timelineAsync = ref.watch(timelineDetailProvider(widget.timelineId));

    final isDark = Theme.of(context).brightness == Brightness.dark;
    Future<void> _refresh(String action) async {
      ref.invalidate(timelineDetailProvider(widget.timelineId));

      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            action == 'deleted'
                ? 'Schedule deleted successfully'
                : 'Schedule updated successfully',
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF6FAF9),

      appBar: AppBar(
        title: Text(t.schedule),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: timelineAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),

        data: (TimelineDetailModel timeline) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// HEADER
                TimelineHeaderCard(timeline: timeline),

                const SizedBox(height: 16),

                /// TAB SYSTEM
                TimelineScheduleTab(
                  controller: _tabController,
                  timeline: timeline,
                  onRefresh: _refresh,
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
