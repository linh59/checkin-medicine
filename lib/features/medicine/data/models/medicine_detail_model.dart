class MedicineDetailModel {
  final String id;
  final String slug;
  final String brand;
  final String? genericName;
  final String? manufacturer;
  final String? form;
  final String? summary;
  final String? servingSize;
  final List<String> warnings;
  final List<MedicineIngredient> ingredients;

  MedicineDetailModel({
    required this.id,
    required this.slug,
    required this.brand,
    this.genericName,
    this.manufacturer,
    this.form,
    this.summary,
    this.servingSize,
    required this.warnings,
    required this.ingredients,
  });

  factory MedicineDetailModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return MedicineDetailModel(
      id: json['id'],
      slug: json['slug'],
      brand: json['brand'] ?? '',
      genericName:
      json['generic_name'],
      manufacturer:
      json['manufacturer'],
      form: json['form'],
      summary: json['summary'],
      servingSize:
      json['serving_size'],
      warnings:
      (json['warnings']
      as List?)
          ?.map(
            (e) =>
            e.toString(),
      )
          .toList() ??
          [],
      ingredients:
      (json[
      'medicine_ingredients']
      as List?)
          ?.map(
            (e) =>
            MedicineIngredient
                .fromJson(e),
      )
          .toList() ??
          [],
    );
  }
}

class MedicineIngredient {
  final String id;
  final double? amountPerPill;
  final String? unit;
  final double? percentDv;
  final IngredientForm?
  ingredientForm;

  MedicineIngredient({
    required this.id,
    this.amountPerPill,
    this.unit,
    this.percentDv,
    this.ingredientForm,
  });

  factory MedicineIngredient.fromJson(
      Map<String, dynamic> json,
      ) {
    return MedicineIngredient(
      id: json['id'],
      amountPerPill:
      (json[
      'amount_per_pill']
      as num?)
          ?.toDouble(),
      unit: json['unit'],
      percentDv:
      (json['percent_dv']
      as num?)
          ?.toDouble(),
      ingredientForm:
      json[
      'ingredient_forms'] !=
          null
          ? IngredientForm
          .fromJson(
        json[
        'ingredient_forms'],
      )
          : null,
    );
  }
}

class IngredientForm {
  final String id;
  final String slug;
  final String name;
  final String? saltForm;
  final String?
  bioavailability;
  final Nutrient? nutrient;

  IngredientForm({
    required this.id,
    required this.slug,
    required this.name,
    this.saltForm,
    this.bioavailability,
    this.nutrient,
  });

  factory IngredientForm.fromJson(
      Map<String, dynamic> json,
      ) {
    return IngredientForm(
      id: json['id'],
      slug: json['slug'],
      name: json['name'] ?? '',
      saltForm:
      json['salt_form'],
      bioavailability:
      json[
      'bioavailability'],
      nutrient:
      json['nutrients'] !=
          null
          ? Nutrient.fromJson(
        json[
        'nutrients'],
      )
          : null,
    );
  }
}

class Nutrient {
  final String id;
  final String slug;
  final String name;
  final String? unit;

  Nutrient({
    required this.id,
    required this.slug,
    required this.name,
    this.unit,
  });

  factory Nutrient.fromJson(
      Map<String, dynamic> json,
      ) {
    return Nutrient(
      id: json['id'],
      slug: json['slug'],
      name: json['name'] ?? '',
      unit: json['unit'],
    );
  }
}