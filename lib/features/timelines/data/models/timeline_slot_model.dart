class TimelineSlotModel {
  final String slotId;
  final String planItemId;

  final String medicineName;
  final String medicineSlug;
  final String? nickname;

  final double dose;

  final String time;

  final String? withFood;
  final String? notes;

  final bool notifyEnabled;
  final int notifyOffsetMin;
  final String? notifySound;

  final int weekdayMask;

  final String repeatKind;
  final int repeatInterval;

  final String myMedicineId;

  const TimelineSlotModel({
    required this.slotId,
    required this.planItemId,
    required this.medicineName,
    required this.medicineSlug,
    required this.nickname,
    required this.dose,
    required this.time,
    required this.withFood,
    required this.notes,
    required this.notifyEnabled,
    required this.notifyOffsetMin,
    required this.notifySound,
    required this.weekdayMask,
    required this.repeatKind,
    required this.repeatInterval,
    required this.myMedicineId,
  });

  factory TimelineSlotModel.fromJson(Map<String, dynamic> json) {
    return TimelineSlotModel(
      slotId: json['slot_id'] ?? '',

      planItemId: json['plan_item_id'] ?? '',

      medicineName: json['medicine_name'] ?? '',

      medicineSlug: json['medicine_slug'] ?? '',

      nickname: json['nickname'],

      dose: double.tryParse(json['dose'].toString()) ?? 1,

      time: json['time'] ?? '08:00',

      withFood: json['with_food'],

      notes: json['notes'],

      notifyEnabled:
          json['notify_enabled'] == true ||
          json['notify_enabled']?.toString() == 'true',

      notifyOffsetMin:
          int.tryParse(json['notify_offset_min']?.toString() ?? '') ?? 0,

      notifySound: json['notify_sound']?.toString(),

      weekdayMask: int.tryParse(json['weekday_mask']?.toString() ?? '') ?? 127,

      repeatKind: json['repeat_kind'] ?? 'daily',

      repeatInterval: int.tryParse(json['repeat_interval'].toString()) ?? 1,

      myMedicineId: json['my_medicine_id'] ?? '',
    );
  }
}
