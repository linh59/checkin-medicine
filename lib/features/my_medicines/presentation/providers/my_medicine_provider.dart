import 'package:checkin_medicine/features/auth/presentation/providers/profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../data/models/my_medicine_model.dart';
import '../../data/repositories/my_medicine_repository.dart';

final myMedicineRepositoryProvider =
Provider<MyMedicineRepository>(
      (ref) =>
      MyMedicineRepository(),
);

final myMedicinesProvider =
FutureProvider<
    List<MyMedicineModel>>(
      (ref) async {
    final activeProfile =
    ref.watch(
      activeProfileProvider,
    );

    final profileId =
        activeProfile.profile?.id;

    if (profileId == null) {
      return [];
    }

    return ref
        .read(
      myMedicineRepositoryProvider,
    )
        .getMyMedicines(
      profileId,
    );
  },
);