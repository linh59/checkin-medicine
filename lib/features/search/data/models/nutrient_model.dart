class NutrientModel {
  final String id;
  final String slug;
  final String name;
  final String category;
  final String? summary;

  NutrientModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.category,
    this.summary,
  });

  factory NutrientModel.fromJson(Map<String, dynamic> json) {
    return NutrientModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      category: json['category'],
      summary: json['summary'],
    );
  }
}