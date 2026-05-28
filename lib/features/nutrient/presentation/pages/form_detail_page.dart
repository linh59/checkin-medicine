import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/form_detail_provider.dart';
import '../providers/ingredient_form_provider.dart';

class FormDetailPage extends ConsumerWidget {
  final String slug;

  const FormDetailPage({
    super.key,
    required this.slug,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final color = Theme.of(context).colorScheme;

    final formAsync = ref.watch(formDetailProvider(slug));

    return Scaffold(
      backgroundColor: color.surfaceContainerLowest,
      body: SafeArea(
        child: formAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),

          error: (e, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(e.toString(), textAlign: TextAlign.center),
            ),
          ),

          data: (form) {
            if (form == null) {
              return Center(child: Text(t.notFound));
            }

            final interAsync = ref.watch(interactionProvider(form.id));

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                /// HEADER APPBAR
                SliverAppBar(
                  floating: true,
                  snap: true,
                  elevation: 0,
                  backgroundColor: color.surface,
                  leading: const BackButton(),
                  title: Text(
                    form.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                /// BODY
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// MAIN CARD
                        _Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                form.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  if (form.saltForm != null)
                                    _Badge(
                                      "${t.salt}: ${form.saltForm}",
                                    ),

                                  if (form.bioavailability != null)
                                    _Badge(
                                      "${t.absorption}: ${form.bioavailability}",
                                    ),
                                ],
                              ),

                              if (form.notes?.isNotEmpty == true) ...[
                                const SizedBox(height: 12),
                                Text(
                                  form.notes ?? '',
                                  style: TextStyle(
                                    height: 1.6,
                                    color: color.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// BENEFITS
                        if (form.benefits.isNotEmpty)
                          _Section(
                            title: t.benefits,
                            icon: Icons.auto_awesome,
                            color: Colors.green,
                            items: form.benefits,
                          ),

                        const SizedBox(height: 16),

                        /// SIDE EFFECTS
                        if (form.sideEffects.isNotEmpty)
                          _Section(
                            title: t.sideEffects,
                            icon: Icons.warning_amber,
                            color: Colors.orange,
                            items: form.sideEffects,
                          ),

                        const SizedBox(height: 20),

                        /// INFO
                        if (form.bestTakenWith != null)
                          _InfoCard(
                            title: t.bestTakenWith,
                            icon: Icons.coffee,
                            content: form.bestTakenWith!,
                          ),

                        if (form.avoidWith != null) ...[
                          const SizedBox(height: 12),
                          _InfoCard(
                            title: t.avoidWith,
                            icon: Icons.block,
                            content: form.avoidWith!,
                            danger: true,
                          ),
                        ],

                        const SizedBox(height: 20),

                        /// INTERACTIONS
                        Text(
                          t.interactions,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),

                        const SizedBox(height: 12),

                        interAsync.when(
                          loading: () =>
                          const CircularProgressIndicator(),

                          error: (e, _) => Text(e.toString()),

                          data: (list) {
                            if (list.isEmpty) {
                              return Text(t.noData);
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: list.map((it) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: color.surface,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    it.description ?? '',
                                    style: const TextStyle(height: 1.5),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// =====================
/// CARD
/// =====================
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

/// =====================
/// BADGE
/// =====================
class _Badge extends StatelessWidget {
  final String text;

  const _Badge(this.text);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// =====================
/// SECTION
/// =====================
class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items.map((e) {
              return ListTile(
                dense: true,
                leading: Icon(Icons.check, size: 18, color: color),
                title: Text(e),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// =====================
/// INFO CARD
/// =====================
class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final bool danger;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.content,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: danger ? Colors.red.withOpacity(0.05) : color.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }
}