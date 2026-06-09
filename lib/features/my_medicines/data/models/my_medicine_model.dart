import 'dart:convert';

import 'package:checkin_medicine/features/search/data/models/medicine_model.dart';

class MyMedicineModel {
  final String id;

  final String profileId;
  final String medicineId;
  final bool canDelete;

  final String? nickname;
  final String? customDosePerTake;
  final String? notes;

  final DateTime? startedAt;

  final bool archived;

  final DateTime createdAt;
  final DateTime updatedAt;

  final MedicineModel? medicine;

  const MyMedicineModel({
    required this.id,
    required this.profileId,
    required this.medicineId,
    required this.canDelete,
    this.nickname,
    this.customDosePerTake,
    this.notes,
    this.startedAt,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
    this.medicine,
  });

  factory MyMedicineModel.fromMap(Map<String, dynamic> map) {
    return MyMedicineModel(
      id: map['id'] ?? '',

      profileId: map['profile_id'] ?? '',
      medicineId: map['medicine_id'] ?? '',

      canDelete: map['can_delete'] ?? true,

      nickname: map['nickname'],
      customDosePerTake: map['custom_dose_per_take'],
      notes: map['notes'],

      startedAt: map['started_at'] != null
          ? DateTime.tryParse(map['started_at'])
          : null,

      archived: map['archived'] == true,

      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),

      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),

      medicine: map['medicines'] != null
          ? MedicineModel.fromJson(map['medicines'])
          : null,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profile_id': profileId,
      'medicine_id': medicineId,
      'nickname': nickname,
      'custom_dose_per_take': customDosePerTake,
      'notes': notes,
      'started_at': startedAt?.toIso8601String(),
      'archived': archived,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory MyMedicineModel.fromJson(String source) {
    return MyMedicineModel.fromMap(json.decode(source));
  }

  String toJson() => json.encode(toMap());
}
