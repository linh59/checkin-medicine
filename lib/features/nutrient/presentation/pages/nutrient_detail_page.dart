import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/nutrient_provider.dart';

import '../widgets/nutrient_forms_section.dart';
import '../widgets/nutrient_header.dart';
import '../widgets/nutrient_loading.dart';
import '../widgets/nutrient_safe_limit_section.dart';

class NutrientDetailPage
    extends ConsumerWidget {
  final String slug;

  final String?
  selectedFormSlug;

  const NutrientDetailPage({
    super.key,
    required this.slug,
    this.selectedFormSlug,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final t =
    AppLocalizations.of(
      context,
    )!;

    final colorScheme =
        Theme.of(context)
            .colorScheme;

    final nutrientAsync =
    ref.watch(
      nutrientDetailProvider(
        slug,
      ),
    );

    return nutrientAsync.when(
      loading: () =>
      const Scaffold(
        body:
        NutrientLoading(),
      ),

      error: (e, _) =>
          Scaffold(
            appBar: AppBar(
              leading:
              const BackButton(),
            ),
            body: Center(
              child: Padding(
                padding:
                const EdgeInsets.all(
                  24,
                ),
                child: Text(
                  e.toString(),
                  textAlign:
                  TextAlign.center,
                ),
              ),
            ),
          ),

      data: (nutrient) {
        if (nutrient ==
            null) {
          return Scaffold(
            appBar: AppBar(
              leading:
              const BackButton(),
            ),
            body: Center(
              child: Text(
                t.notFound,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor:
          colorScheme
              .surfaceContainerLowest,

          extendBodyBehindAppBar:
          false,

          body: SafeArea(
            top: false,

            child:
            NestedScrollView(
              headerSliverBuilder:
                  (_, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  snap: false,

                  elevation: 0,
                  scrolledUnderElevation:
                  0,

                  backgroundColor:
                  colorScheme
                      .surface,

                  surfaceTintColor:
                  Colors
                      .transparent,

                  leading:
                  const BackButton(),

                  title: AnimatedOpacity(
                    duration:
                    const Duration(
                      milliseconds:
                      200,
                    ),

                    opacity:
                    innerBoxIsScrolled
                        ? 1
                        : 0,

                    child: Text(
                      nutrient.name,
                      maxLines: 1,
                      overflow:
                      TextOverflow
                          .ellipsis,
                    ),
                  ),
                ),
              ],

              body:
              SingleChildScrollView(
                padding:
                const EdgeInsets
                    .fromLTRB(
                  20,
                  20,
                  20,
                  32,
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [
                    /// HEADER
                    NutrientHeader(
                      nutrient:
                      nutrient,
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    /// SAFE LIMIT
                    NutrientSafeLimitSection(
                      nutrient:
                      nutrient,
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    /// FORMS
                    NutrientFormsSection(
                      nutrient:
                      nutrient,

                      selectedFormSlug:
                      selectedFormSlug,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}