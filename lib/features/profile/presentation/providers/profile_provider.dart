// lib/features/profile/presentation/providers/profile_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobadulu/features/profile/data/models/profile_model.dart';
import 'package:cobadulu/features/profile/data/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  final ProfileRepository _repo;

  ProfileNotifier(this._repo) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    try {
      final p = await _repo.getProfile();
      state = AsyncValue.data(p);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async => loadProfile();

  /// Update profile (partial/full) via repository and update state
  Future<void> updateProfile(ProfileModel newProfile) async {
    state = const AsyncValue.loading();
    try {
      final updated = await _repo.updateProfile(newProfile);
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Helper untuk update field tertentu (tidak mengganti seluruh object)
  Future<void> updateProfileFields({
    String? nama,
    String? nomorHp,
    String? jurusan,
    String? angkatan,
    String? avatarUrl,
  }) async {
    final cur = state.value;
    if (cur == null) return await loadProfile();
    final next = cur.copyWith(
      nama: nama,
      nomorHp: nomorHp,
      jurusan: jurusan,
      angkatan: angkatan,
      avatarUrl: avatarUrl,
    );
    await updateProfile(next);
  }
}

final profileNotifierProvider = StateNotifierProvider.autoDispose<
    ProfileNotifier, AsyncValue<ProfileModel>>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repo);
});