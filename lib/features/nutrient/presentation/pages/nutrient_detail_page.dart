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

  const NutrientDetailPage({
    super.key,
    required this.slug,
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

    final nutrientAsync =
    ref.watch(
      nutrientDetailProvider(
        slug,
      ),
    );

    return nutrientAsync.when(
      loading:
          () =>
      const Scaffold(
        body:
        NutrientLoading(),
      ),

      error:
          (e, _) => Scaffold(
        appBar:
        AppBar(
          leading:
          const BackButton(),
        ),
        body: Center(
          child:
          Text(
            e.toString(),
          ),
        ),
      ),

      data: (nutrient) {
        if (nutrient ==
            null) {
          return Scaffold(
            appBar:
            AppBar(
              leading:
              const BackButton(),
            ),
            body: Center(
              child:
              Text(
                t.notFound,
              ),
            ),
          );
        }

        return Scaffold(
          body:
          NestedScrollView(
            headerSliverBuilder:
                (_, __) => [
              SliverAppBar(
                floating:
                true,
                snap:
                true,
                leading:
                const BackButton(),
                title:
                Text(
                  nutrient
                      .name,
                ),
              ),
            ],

            body:
            SingleChildScrollView(
              padding:
              const EdgeInsets.all(
                16,
              ),
              child:
              Column(
                children: [
                  NutrientHeader(
                    nutrient:
                    nutrient,
                  ),

                  const SizedBox(
                    height:
                    24,
                  ),

                  NutrientSafeLimitSection(
                    nutrient:
                    nutrient,
                  ),

                  const SizedBox(
                    height:
                    24,
                  ),

                  NutrientFormsSection(
                    nutrient:
                    nutrient,
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