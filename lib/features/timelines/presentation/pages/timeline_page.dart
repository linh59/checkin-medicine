import 'package:checkin_medicine/features/timelines/presentation/widgets/error_plan.dart';
import 'package:checkin_medicine/features/timelines/presentation/widgets/header_summary.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkin_medicine/features/timelines/presentation/providers/timelines_provider.dart';
import 'package:checkin_medicine/shared/widgets/profile_switcher.dart';

import '../widgets/plan_card.dart';
import '../widgets/loading_plan.dart';
import '../widgets/empty_plan.dart';

class TimelinePage extends ConsumerWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;
    final plansAsync = ref.watch(plansProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.schedule,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [ProfileSwitcher(), SizedBox(width: 8)],
      ),

      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: plansAsync.when(
            loading: () => const LoadingPlan(),

            error: (e, _) => ErrorPlan(error: e.toString()),

            data: (plans) {
              if (plans.isEmpty) {
                return const EmptyPlan();
              }

              return Column(
                children: [
                  HeaderSummary(count: plans.length),

                  const SizedBox(height: 8),

                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: plans.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        return PlanCard(plan: plans[i]);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
