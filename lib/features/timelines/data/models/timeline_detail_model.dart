import 'timeline_slot_model.dart';

class TimelineDetailModel {
  final String id;
  final String name;
  final String notes;

  final bool isActive;
  final String color;
  final String mode;

  final String profileId;
  final String profileName;
  final int? birthYear;

  final List<TimelineSlotModel> slots;

  const TimelineDetailModel({
    required this.id,
    required this.name,
    required this.notes,
    required this.isActive,
    required this.color,
    required this.mode,
    required this.profileId,
    required this.profileName,
    required this.birthYear,
    required this.slots,
  });

  factory TimelineDetailModel.fromJson(Map<String, dynamic> json) {
    final planItems = json['plan_items'] as List<dynamic>? ?? [];

    final List<TimelineSlotModel> slots = [];

    for (final item in planItems) {
      final schedules = item['plan_schedule'] as List<dynamic>? ?? [];

      for (final schedule in schedules) {
        slots.add(
          TimelineSlotModel(
            slotId: schedule['id'] ?? '',

            planItemId: item['id'] ?? '',

            medicineName: item['my_medicines']?['medicines']?['brand'] ?? '',

            medicineSlug: item['my_medicines']?['medicines']?['slug'] ?? '',

            nickname: item['my_medicines']?['nickname'],

            dose: double.tryParse(item['dose_per_take'].toString()) ?? 1,

            time: (schedule['time_of_day'] ?? '08:00:00').toString().substring(
              0,
              5,
            ),

            withFood: schedule['with_food'],

            notes: schedule['notes'],

            notifyEnabled:
                schedule['notify_enabled'] == true ||
                schedule['notify_enabled']?.toString() == 'true',

            notifyOffsetMin:
                int.tryParse(schedule['notify_offset_min']?.toString() ?? '') ??
                0,

            notifySound: schedule['notify_sound']?.toString(),

            weekdayMask:
                int.tryParse(schedule['weekday_mask']?.toString() ?? '') ?? 127,

            repeatKind: item['repeat_kind'] ?? 'daily',

            repeatInterval:
                int.tryParse(item['repeat_interval'].toString()) ?? 1,

            myMedicineId: item['my_medicines']?['id'] ?? '',
          ),
        );
      }
    }

    slots.sort((a, b) => a.time.compareTo(b.time));

    return TimelineDetailModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      notes: json['notes'] ?? '',
      isActive: json['is_active'] == true,
      color: json['color'] ?? 'amber',
      mode: json['mode'] ?? 'manual',
      profileId: json['profile_id'] ?? '',
      profileName: json['managed_profiles']?['full_name'] ?? '',
      birthYear: json['managed_profiles']?['birth_year'],
      slots: slots,
    );
  }
}
