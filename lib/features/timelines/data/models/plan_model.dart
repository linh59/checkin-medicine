class PlanModel {
  final String id;
  final String profileId;
  final String name;
  final String notes;
  final bool isActive;
  final String mode;
  final String color;
  final DateTime createdAt;

  final int itemCount;
  final bool archived;

  PlanModel({
    required this.id,
    required this.profileId,
    required this.name,
    required this.notes,
    required this.isActive,
    required this.mode,
    required this.color,
    required this.createdAt,
    required this.itemCount,
    required this.archived,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    final items = json['plan_items'] as List<dynamic>?;

    int count = 0;
    if (items != null && items.isNotEmpty) {
      count = items.first['count'] ?? 0;
    }

    return PlanModel(
      id: json['id'],
      profileId: json['profile_id'],
      name: json['name'] ?? '',
      notes: json['notes'] ?? '',
      isActive: json['is_active'] == true || json['is_active'] == 'true',
      mode: json['mode'] ?? 'manual',
      color: json['color'] ?? 'amber',
      createdAt: DateTime.parse(json['created_at']),
      itemCount: count,
      archived:
          json['archived'] == true || json['archived']?.toString() == 'true',
    );
  }
}
