class IngredientFormModel {
  final String id;
  final String slug;
  final String name;
  final String? saltForm;
  final String? bioavailability;

  IngredientFormModel({
    required this.id,
    required this.slug,
    required this.name,
    this.saltForm,
    this.bioavailability,
  });

  factory IngredientFormModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return IngredientFormModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      saltForm:
      json['salt_form'],
      bioavailability:
      json['bioavailability'],
    );
  }
}