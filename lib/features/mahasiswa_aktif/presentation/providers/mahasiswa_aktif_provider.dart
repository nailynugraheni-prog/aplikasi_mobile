import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobadulu/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:cobadulu/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';

final mahasiswaAktifRepositoryProvider =
Provider<MahasiswaAktifRepository>((ref) {
  return MahasiswaAktifRepository();
});

class MahasiswaAktifState {
  final List<MahasiswaAktifModel> sourceList;
  final List<MahasiswaAktifModel> filteredList;
  final String query;

  MahasiswaAktifState({
    required this.sourceList,
    required this.filteredList,
    required this.query,
  });

  factory MahasiswaAktifState.initial() =>
      MahasiswaAktifState(sourceList: [], filteredList: [], query: '');

  MahasiswaAktifState copyWith({
    List<MahasiswaAktifModel>? sourceList,
    List<MahasiswaAktifModel>? filteredList,
    String? query,
  }) {
    return MahasiswaAktifState(
      sourceList: sourceList ?? this.sourceList,
      filteredList: filteredList ?? this.filteredList,
      query: query ?? this.query,
    );
  }
}

class MahasiswaAktifNotifier
    extends StateNotifier<AsyncValue<MahasiswaAktifState>> {
  final MahasiswaAktifRepository _repo;

  MahasiswaAktifNotifier(this._repo)
      : super(const AsyncValue.loading()) {
    loadAktif();
  }

  Future<void> loadAktif() async {
    state = const AsyncValue.loading();
    try {
      final list = await _repo.getMahasiswaAktifList(); // ✅ FIXED
      state = AsyncValue.data(
        MahasiswaAktifState(
          sourceList: List<MahasiswaAktifModel>.from(list),
          filteredList: List<MahasiswaAktifModel>.from(list),
          query: '',
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async => loadAktif();

  void setSearchQuery(String q) {
    final cur = state.value;
    if (cur == null) return;

    final trimmed = q.trim();
    final lower = trimmed.toLowerCase();

    final filtered = cur.sourceList.where((m) {
      final title = m.title.toLowerCase(); // ✅ FIXED
      final body = m.body.toLowerCase();   // ✅ FIXED
      return title.contains(lower) || body.contains(lower);
    }).toList();

    state = AsyncValue.data(
      cur.copyWith(query: trimmed, filteredList: filtered),
    );
  }

  void clearSearch() {
    final cur = state.value;
    if (cur == null) return;

    state = AsyncValue.data(
      cur.copyWith(
        query: '',
        filteredList: List.from(cur.sourceList),
      ),
    );
  }
}

final mahasiswaAktifNotifierProvider = StateNotifierProvider.autoDispose<
    MahasiswaAktifNotifier,
    AsyncValue<MahasiswaAktifState>>((ref) {
  final repo = ref.watch(mahasiswaAktifRepositoryProvider);
  return MahasiswaAktifNotifier(repo);
});