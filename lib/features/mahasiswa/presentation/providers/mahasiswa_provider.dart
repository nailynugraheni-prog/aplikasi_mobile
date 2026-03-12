// lib/features/mahasiswa/presentation/providers/mahasiswa_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobadulu/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:cobadulu/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

// Repository provider
final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

// StateNotifier untuk daftar mahasiswa
class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;

  MahasiswaNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaList();
  }
}

// Provider
final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<
    MahasiswaNotifier,
    AsyncValue<List<MahasiswaModel>>>((ref) {
  final repo = ref.watch(mahasiswaRepositoryProvider);
  return MahasiswaNotifier(repo);
});