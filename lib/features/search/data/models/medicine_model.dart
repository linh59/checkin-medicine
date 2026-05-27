class MedicineModel {
  final String id;
  final String slug;
  final String brand;
  final String? genericName;
  final String? manufacturer;
  final String form;

  MedicineModel({
    required this.id,
    required this.slug,
    required this.brand,
    required this.form,
    this.genericName,
    this.manufacturer,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'],
      slug: json['slug'],
      brand: json['brand'],
      genericName: json['generic_name'],
      manufacturer: json['manufacturer'],
      form: json['form'],
    );
  }
}