class ManagedProfile {
  final String id;

  final String fullName;
  final String? avatarUrl;

  final String? dob;
  final int? birthYear;
  final String? gender;

  final List<String> groupKinds;

  final String? notes;

  final String? linkedUserId;
  final String createdBy;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ManagedProfile({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.dob,
    this.birthYear,
    this.gender,
    required this.groupKinds,
    this.notes,
    this.linkedUserId,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory ManagedProfile.fromMap(
      Map<String, dynamic> map,
      ) {
    return ManagedProfile(
      id: map['id'] ?? '',

      fullName:
      map['full_name'] ?? '',

      avatarUrl:
      map['avatar_url'],

      dob: map['dob'],

      birthYear:
      map['birth_year'] is int
          ? map['birth_year']
          : int.tryParse(
        map['birth_year']
            ?.toString() ??
            '',
      ),

      gender:
      map['gender'],

      groupKinds:
      _parseGroupKinds(
        map['group_kinds'],
      ),

      notes:
      map['notes'],

      linkedUserId:
      map['linked_user_id'],

      createdBy:
      map['created_by'] ?? '',

      createdAt:
      DateTime.tryParse(
        map['created_at']
            ?.toString() ??
            '',
      ),

      updatedAt:
      DateTime.tryParse(
        map['updated_at']
            ?.toString() ??
            '',
      ),
    );
  }

  static List<String>
  _parseGroupKinds(
      dynamic value,
      ) {
    if (value == null) {
      return [];
    }

    if (value is List) {
      return List<String>.from(
        value,
      );
    }

    return value
        .toString()
        .replaceAll('{', '')
        .replaceAll('}', '')
        .split(',')
        .where(
          (e) =>
      e.trim().isNotEmpty,
    )
        .toList();
  }
}