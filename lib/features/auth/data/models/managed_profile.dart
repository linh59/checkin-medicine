class ManagedProfileModel {
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

  final DateTime createdAt;
  final DateTime updatedAt;

  const ManagedProfileModel({
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory ManagedProfileModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return ManagedProfileModel(
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
      ) ??
          DateTime.now(),

      updatedAt:
      DateTime.tryParse(
        map['updated_at']
            ?.toString() ??
            '',
      ) ??
          DateTime.now(),
    );
  }

  static List<String>
  _parseGroupKinds(
      dynamic value,
      ) {
    /// Supabase postgres array:
    /// "{adult,child}"

    if (value == null) {
      return [];
    }

    if (value is List) {
      return List<String>.from(
        value,
      );
    }

    final text =
    value.toString();

    return text
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