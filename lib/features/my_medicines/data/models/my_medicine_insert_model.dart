class MyMedicineInsert {
  final String profileId;
  final String medicineId;
  final String? nickname;
  final String? notes;

  MyMedicineInsert({
    required this.profileId,
    required this.medicineId,
    this.nickname,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'medicine_id': medicineId,
      'nickname': nickname,
      'notes': notes,
    };
  }
}
