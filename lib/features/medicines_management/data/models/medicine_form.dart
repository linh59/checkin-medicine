import 'dart:convert';

import 'package:checkin_medicine/features/medicine/data/models/medicine_ingredient.dart';
import 'package:checkin_medicine/features/medicines_management/data/models/medicine_ingredient_input.dart';

class MedicineForm {
  final String slug;

  final String brand;
  final String genericName;
  final String? manufacturer;

  final String? form;

  final String? summary;
  final String? description;

  final List<String>? warnings;

  final String? category;
  final String? country;

  final int? pillsPerServing;
  final List<MedicineIngredientInput> ingredients;

  final String sourceName;
  final String? sourceUrl;

  MedicineForm({
    required this.slug,
    required this.brand,
    required this.genericName,
    this.manufacturer,
    this.form,
    this.summary,
    this.description,
    this.warnings,
    this.category,
    this.country,
    this.pillsPerServing,
    required this.ingredients,
    required this.sourceName,
     this.sourceUrl
  });

  factory MedicineForm.fromJson(Map<String, dynamic> json) {
    return MedicineForm(
      slug: json['slug'] ?? '',

      brand: json['brand'] ?? '',
      genericName: json['generic_name'] ?? '',
      manufacturer: json['manufacturer'] ?? '',

      form: json['form'] ?? '',

      summary: json['summary'],
      description: json['description'],

      warnings: _parseList(json['warnings']),

      category: json['category'],
      country: json['country'],

      pillsPerServing: int.tryParse(
        json['pills_per_serving']?.toString() ?? '',
      ),

      /// Parse relation
      ingredients:
          (json['medicine_ingredients'] as List?)
              ?.map((e) => MedicineIngredientInput.fromJson(e))
              .toList() ??
          [],
      sourceName: json['source_name'],
      sourceUrl: json['source_url'],
    );
  }

  static List<String> _parseList(dynamic value) {
    if (value == null) {
      return [];
    }

    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }

    if (value is String) {
      try {
        final decoded = jsonDecode(value);

        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
    }

    return [];
  }
}
