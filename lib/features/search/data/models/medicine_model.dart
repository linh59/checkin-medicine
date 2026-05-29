class MedicineModel {
  final String id;
  final String slug;
  final String brand;
  final String? genericName;
  final String? manufacturer;
  final String form;
  final String? createdBy;

  MedicineModel({
    required this.id,
    required this.slug,
    required this.brand,
    required this.form,
    this.genericName,
    this.manufacturer,
    this.createdBy
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'],
      slug: json['slug'],
      brand: json['brand'],
      genericName: json['generic_name'],
      manufacturer: json['manufacturer'],
      form: json['form'],
      createdBy:
      json['created_by'],
    );
  }

  factory MedicineModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return MedicineModel(
      id: map['id'] ?? '',
      slug: map['slug'] ?? '',

      brand: map['brand'] ?? '',

      genericName:
      map['generic_name'] ?? '',

      form: map['form'],

      createdBy:
      map['created_by'],
    );
  }
}