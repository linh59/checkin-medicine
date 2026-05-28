import 'package:checkin_medicine/features/nutrient/data/models/nutrient_model.dart';

class IngredientForm {
  final String id;
  final String slug;
  final String name;

  final String? saltForm;
  final String? bioavailability;

  final double? elementalRatio;

  final String? notes;
  final String? bestTakenWith;
  final String? avoidWith;

  final List<String> benefits;
  final List<String> sideEffects;

  final NutrientModel? nutrient;

  IngredientForm({
    required this.id,
    required this.slug,
    required this.name,
    required this.saltForm,
    required this.bioavailability,
    required this.elementalRatio,
    required this.notes,
    required this.bestTakenWith,
    required this.avoidWith,
    required this.benefits,
    required this.sideEffects,
    required this.nutrient,
  });

  factory IngredientForm.fromJson(
      Map<String, dynamic> json,
      ) {
    return IngredientForm(
      id: json['id'].toString(),

      slug: json['slug'] ?? '',

      name: json['name'] ?? '',

      saltForm: json['salt_form'],

      bioavailability:
      json['bioavailability'],

      elementalRatio:
      double.tryParse(
        json['elemental_ratio']
            ?.toString() ??
            '',
      ),

      notes: json['notes'],

      bestTakenWith:
      json['best_taken_with'],

      avoidWith:
      json['avoid_with'],

      benefits:
      (json['benefits']
      as List?)
          ?.map(
            (e) =>
            e.toString(),
      )
          .toList() ??
          [],

      sideEffects:
      (json['side_effects']
      as List?)
          ?.map(
            (e) =>
            e.toString(),
      )
          .toList() ??
          [],

      nutrient:
      json['nutrients'] !=
          null
          ? NutrientModel
          .fromJson(
        json[
        'nutrients'
        ],
      )
          : null,
    );
  }
}